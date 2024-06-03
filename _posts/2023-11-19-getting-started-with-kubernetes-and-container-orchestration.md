---
layout: post
title: "Getting Started With Kubernetes And Container Orchestration"
date: 2023-11-19 08:55:54 +0000
categories: kubernetes
tags: automate kubernetes
image: 
  path: /assets/img/posts/kubernetes-architecture-diagram.webp
  lqip: ""
---

***The easiest way to install kubernetes is to get someone else to do it for you  <br>~Jérôme Petazzoni***


[image by Lucas Käldström!]()

## what problems does kubernetees solve
microservice growth from monolith lead to kubernetes to manage increased usage of containers

### what's offered
- High availability
- Scalability or high perfomance
- Disaster recovery 

## Main kubernetes components
 - Node
 [![Node architecture](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAAFCAYAAAB8ZH1oAAAAAklEQVR4AewaftIAAACoSURBVE3B2QoBUQCA4f+YkyUlS5nIcqEsF+6Vp/BE3sJjcWG7GFuyC1kaw4xzJCnfJzrWVl/vDqbRx0xmIFxltHrSnTo06hF+fNZyR9JMYLtPXNfjsJkRMzbU8gcuxzWOfcV+KCRK0R5OeN2jxNMlcrkQ0hB8vOwe50ULV0mkFoJKIYu3nxPyLE63MkopvgrIVJOglEgDGAzGOI8EZrZIxB9Aa40Qgn9vi6lGg5gADQgAAAAASUVORK5CYII=)(../assets/img/posts/kubernetes-node-architecture-2023-12-03-19-37-22.webp)]
    - **pod** 
       - smallest unit in kubernetes and provides abstraction over container
       - usually one application per pod
       - Each pod gets its own ip address
       - they are ephemeral (die easilly and re-created)
       - gets new ip on recreation
    - **service** 
      - Two types: 
          - `Extenal` - provides communication to external sources
             - default structure of ip `http//node-ip:port` example `http://124.89.101.2:8080`
          - `Internal` - specified when creating one
             - structure `http://db-service-ip:port`
      - permanent ip address that can be attached to a pod
      - lifecycle of pod and service are not connected
      - type of service is specified during creation
    - **Ingress**
      - Forwards requests to service
      - it may provide loadbalancing, ssl termination and name-based virtual hosting
- **Deployment**
  - blueprint for pods and acts as an abstraction layer
  - We mostly create deployments
  - does not have state and cannot manage db, stateful apps are managed by `Statefulsets`
> DB are often hosted outside kubernetes cluster 
{: .prompt-info }
- **Daemonsets**
  - automatically calculates howmany replicas are needed based on existing nodes
  - automatically scales up and down
  - deploys one replica per node

## Kubernetes Architecture

 - Worker Machine/Nodes
    - do the actual work
    - each node has multiple pods
    - has 3 processes that must be running on each node
      - container runtime i.e `docker`, `containerd` and `cri-o`
      - kubelet service starts a pod with a container inside
      - kube proxy forwards requests

 - Master Processes  
    - api server 
      - acts as a cluster gateway that gets initial requests
      - authenticates requests
    - scheduler
      - basically assigns pods to nodes
      - looks at resources and decides where to put the new pod on a node
      - *kubelet is responsible for starting the pod not the scheduler*
    - controller manager
      - daemon that detects cluster change i.e. pod crashing and tries to recover cluster state
      - it sends request to scheduler to reschedule the pods
    - etcd
      - key value store of cluster state info
      - actual app data is not stored here

## How to manage K8s components

### How to create k8s components
 - using kubernetes cli: `kubectl`
    - imperative way
    - Limitation multiple commands and parameters
    - use cases:
        - testing
        - quick one-off tasks
        - when getting started 
 - kubernetes config files: `kubernetes manifests`
    - declarative way
    - multiple components can be configured in 1 file and updated with single command `kubectl apply -f <name_of_config.yml>`
    - updates and deletion are supported
    - benefits:
        - more transparent
        - history configurations
        - collaboration and review process made possible
        - enables iaas in git 

### Kubernetes config file
  - 3 parts of k8s config
    - metadata
    - specification
    - status - automatically genrated by kubernetes and helps in state management (comes from etcd)
> Yaml validator can help in parsing large configs [yamtools](https://onlineyamltools.com/edit-yaml). Refer [here](https://www.cloudbees.com/blog/yaml-tutorial-everything-you-need-get-started) for yaml syntax 
{: .prompt-info }


## Creating cluster on AWS

- create a vpc
- launch 3 ec2 instances min 2gb ram 2cp2
    - t2 medium - master
    - t2 large - worker nodes

### WHAT TO INSTALL
On control plane and Worker nodes:
  - container runtime
  - kubelet
  
On control plane alone:
  - 
  



manually setting up [kubernetes] (https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)

- kubeadm - commandline tool to initialize the cluster
- kubelet - starts pods and containers, runs on all machines on your cluster
- kubectl - commandline tool to talk to cluster

change ownership of file
```shell
sudo chown $(id -u):$(id -g) ~/.kube/config
```

## Namespaces
`kubectl get ns` # list namespaces
`kubectlget pod -n <name_of_the_namespace>`

Namespace benefits:
  - structure components
  - avoid conflicts between teams
  - share services between different environments
  - Acess and Resouce limits
resources that can be shared between namespaces:
 - services i.e db, nginx, 
 - volumes
 `kunectl api-resources --namespaced=false` # check resources that are not bound in namespace