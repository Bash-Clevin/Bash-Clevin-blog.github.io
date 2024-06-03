---
layout: post
title: "Deploying Ethereum Full Node on Holesky Test Net"
date: 2024-06-03 06:54:52 +0000
categories: blochchain
tags: crypto docker eth
image:
  path: /assets/img/headers/full-node-on-holesky.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAgACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APRP2qP2d/25dX+M/gPU/gPdauvw5ey0QXS6br/hrS/D2iaxbapdnxCfiDoOsalp2seIbO/s57ea1lsLPXrVLCL7NBaw6vbKJfwjiHL+OHxVhquWqr/ZKhhlCSxFSnhIrnk8UsRQpyqUq03yxlevR55QqKlh615VIR+pweLyf+zairNRxKc2/wB2pVXK6dPlk0moyi+W1OdoOMpVFH3ZP75T4DSbE32iF9q7yqHbuwN23PO3OcZ7V+i+x/6cz+cdfnrueIsXOy9+W3d/5P8AM//Z
---

[Photo by David McBee](https://www.pexels.com/photo/round-gold-colored-ethereum-ornament-730552/)

## Getting started with running a full node on Holesky testnet

### Requirements

The consensus client used in this guide is [Lighthouse](https://lighthouse-book.sigmaprime.io/docker.html) and [Nethermind](https://github.com/NethermindEth/nethermind) as the execution layer.

Since we will be deploying to various systems, [docker](https://docs.docker.com/get-started/) and [docker compose](https://docs.docker.com/compose/) will be used as the deployment agent.

### Setting up
First create a local working directory with your desired name, for this example we will be working on `nethermind-node`

```shell
mkdir nethermind-node
```

change into the directory and open it in your desired code editor, for our case vscode was used.

```shell
cd nethermind-node && code .
```

we will then create a docker compose file and two other directories to persist our docker container data.

The two folders to create are `lighthouse_data` and `nethermind_data`, after which we will end up with a folder structure similar to this:

```
nethermind-node
|  docker-compose.yaml
|  
|__lighthouse_data
|__nethermind_data
```

We will also need to generate a JWT secret that will be used by both consensus client and execution client for communication.

```shell
  openssl rand -hex 32 | tr -d "\n" > "./jwtsecret"
```

> If you do not specify a JWT secret, then the execution and/or consensus layer client will automatically generate one for you
{: .prompt-info}

### Setting up the Execution Client

Inside our `docker-compose.yaml` file we will setup a nethermind service following the guideline in their [client website documentation.](https://docs.nethermind.io/get-started/installing-nethermind#docker-container)

```yaml
version: '3.8'

services:
  nethermind:
    image: nethermind/nethermind
    container_name: nethermind
    volumes:
      - ./nethermind_data:/nethermind/data
      - ./jwtsecret:/nethermind/jwtsecret
    ports:
      - 8545:8545
      - 8551:8551
    command: |
      --config holesky
      --JsonRpc.Enabled true
      --JsonRpc.Host=0.0.0.0
      --JsonRpc.JwtSecretFile /nethermind/jwtsecret
    network_mode: host
```
Here we are defaulting to use the default latest image from nethermind `nethermind/nethermind`, then mounting the earlier generated jwt secret to nethermind service, together with a volume for data persistence.

In the command section we are setting the configuration to use holesky `--config holesky`.

we then enable the json rpc and bind it to the localhost adderess in the container.

We are then instructing nethermind service to use the pregenerated JWT secret which is currently mounted in `/nethermind/jwtsecret`

> For more information on setting up the execution client you can reffer to the [official docs](https://docs.nethermind.io/get-started/installing-nethermind)
{: .prompt-info}

### Setting up the Consensus Client

For serring up Lighthouse we follow a similar approach to the execution client.

In the same `docker-compos.yaml` add the following configurations:

```yaml
  lighthouse:
    image: sigp/lighthouse
    container_name: lighthouse
    volumes:
      - ./lighthouse_data:/root/.lighthouse
      - ./jwtsecret:/lighthouse/jwtsecret
    ports:
      - 9000:9000
      - 9001:9001
      - 5052:5052
    network_mode: host
    command: |
      lighthouse
      bn
      --http
      --http-address 0.0.0.0
      --network holesky
      --execution-endpoint http://localhost:8551/
      --execution-jwt /lighthouse/jwtsecret
      --checkpoint-sync-url-timeout 1000
      --checkpoint-sync-url https://holesky.beaconstate.info
```
Same as the execution client we use default to `sigp/lighthouse` latest image.

We mount the data volume `lighthouse_data` and the JWT secret.

we pass command arguments to choose holesky, execution-endpoint url which will be accessible at  `http://localhost:8551/` the jwt token that we genrated.

The checkpoint sync url is important to prevent downloading unncessary historic data which could be huge. 

Checkpoint sync timeout was set to handle slower connection and prevent sync from timing out.

>More information on setting up a node can be found [here](https://lighthouse-book.sigmaprime.io/run_a_node.html#step-3-set-up-a-beacon-node-using-lighthouse) 
{: .prompt-info}

### Deploying the full node locally

After completing the above steps you should have a compose file similar to this:

```yaml
version: '3.8'

services:
  nethermind:
    image: nethermind/nethermind
    container_name: nethermind
    volumes:
      - ./nethermind_data:/nethermind/data
      - ./jwtsecret:/nethermind/jwtsecret
    ports:
      - 8545:8545
      - 8551:8551
    command: |
      --config holesky
      --JsonRpc.Enabled true
      --JsonRpc.Host=0.0.0.0
      --JsonRpc.JwtSecretFile /nethermind/jwtsecret
    network_mode: host
  
  lighthouse:
    image: sigp/lighthouse
    container_name: lighthouse
    volumes:
      - ./lighthouse_data:/root/.lighthouse
      - ./jwtsecret:/lighthouse/jwtsecret
    ports:
      - 9000:9000
      - 9001:9001
      - 5052:5052
    network_mode: host
    command: |
      lighthouse
      bn
      --http
      --http-address 0.0.0.0
      --network holesky
      --execution-endpoint http://localhost:8551/
      --execution-jwt /lighthouse/jwtsecret
      --checkpoint-sync-url-timeout 1000
      --checkpoint-sync-url https://holesky.beaconstate.info
```

The next step is just running the command below in a VSCODE terminal winndow, **make sure you are in the same folder** as the `docker-compose.yaml` file: 

```bash
docker compose up
```

![docker compose output](/assets/img/posts/run-docker-compose-up.webp)

>Lighthouse beacon node will take time to sync on the first setup. You can also use other [public sync endpoints](https://eth-clients.github.io/checkpoint-sync-endpoints/) if you encounter problems.
{: .prompt-info}

### Testing the endpoints

After both the executor and consensus client are up and running, you can send requests to the executor layer JSSON-RPC and consensus client api.

The endpoints avalable for the consensuss client are documented [here](https://lighthouse-book.sigmaprime.io/api-lighthouse.html)

While for the executor are located [here](https://docs.nethermind.io/interacting/json-rpc-ns/eth)

#### sample requests:

We will run the command:
```bash
curl -X GET "http://localhost:5052/lighthouse/health" -H  "accept: application/json" | jq
```

we are get a response:

![lighthouse health api response](/assets/img/posts/lighthouse_api_response.webp)

> If lighthose client has not started fully you might get a network reset by peer error {: .prompt-info}

For the Nethermind executor client we will run:

```shell
curl localhost:8545 -X POST   -H "Content-Type: application/json"   --data '{
    "jsonrpc": "2.0",
    "id": 0,
    "method": "eth_blobBaseFee",
    "params": []
  }' | jq 
```

We will receive a response:

![nethermind executor response](/assets/img/posts/nethermind_eth_response.webp)

With that we have successfully deployed a full node on our machines. Note that there are other ways of deploying the node which does not involve docker or docker compose.

Docker was only used to avoid installing unnecessary packages in our system and to make sure that we can have same setup in different os types.

### References

[Nethermind official docs](https://docs.nethermind.io/)

[Lighthouse official docs](https://lighthouse-book.sigmaprime.io/intro.html)

[Holesky repo](https://github.com/eth-clients/holesky)

[Ethereum holesky node setup](https://notes.ethereum.org/@launchpad/holesky)