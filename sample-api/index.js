const resp = require('./responses.json')
const cors = require('cors')
const express = require('express')
const app = express()
const port = 3000

app.use(cors())

app.get("/", (req , res)=>{
    const vari = req.query.variant
    const newres = resp[`${vari}`]
    res.json(newres)
})

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
  })