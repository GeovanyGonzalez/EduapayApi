
import express from 'express'
import UsuariosRoutes from "./routes/UsuariosRoutes.js"
import authRoutes from "./routes/auth.js"




const app = express()
app.use(express.json())

app.use(`/api`,UsuariosRoutes)
app.use(`/api`, authRoutes)



app.listen(2077)
console.log('server on port ', 2077);