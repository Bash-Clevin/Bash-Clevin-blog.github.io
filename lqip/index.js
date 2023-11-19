const lqip = require('lqip');
const path = require('path');

const genarateLqip = async (filepath) => {
  try {
    const result = await lqip.base64(filepath)
    console.log('LQIP:', result)
  } catch (error) {
    console.error('Error', error)    
  }
}

const filepath = process.argv[2]

if(!filepath) {
  console.error('Please provide a file path as a command-line argument.')
} else {
  genarateLqip(filepath)
}
