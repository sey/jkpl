const express = require('express')

const app = express()

app.get('/', (req, res) => {
  console.time(req.url)
  res.send('Hello Florian!')
  console.log('response sent')
  console.warn('response sent')
  console.error('response sent')
  console.timeEnd(req.url)
})

app.listen(5000, () => {
  console.log('Server listening on port http://localhost:5000/')
})