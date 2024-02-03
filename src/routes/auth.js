import { Router } from "express";
import { PrismaClient } from "@prisma/client";
import { error } from "console";
import { encrypt, compare } from '../helpper/handleBcryps.js';
const router = Router();
const prisma = new PrismaClient();

router.post("/login", async (req, res)=>{
    const {CorreoElectronico, Contrasena} = req.body
    console.log(CorreoElectronico,Contrasena);
    const usuario = await prisma.usuarios.findFirst({
        where: {
            CorreoElectronico : CorreoElectronico
        }
    })
    if (!usuario) {
        res.status(404)
        res.json('Usuario no encotrado')
    }

    const ConstraseñaVerificada = await compare(Contrasena, usuario.Contrasena )
    if (ConstraseñaVerificada) {
       return res.send(usuario)
    }

    if (!ConstraseñaVerificada) {
        res.status(409)
        return res.send({ error : 'Contraseña incorrecta'})
    }
})

export default router;