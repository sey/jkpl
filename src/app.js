const express = require('express')

const app = express()

app.get('/', (req, res) => {
  console.time(req.url)
  res.send('Hello Florian Sey!')
  console.timeEnd(req.url)
})

app.listen(5000, () => {
  console.log('Server listening on port http://localhost:5000/')
})