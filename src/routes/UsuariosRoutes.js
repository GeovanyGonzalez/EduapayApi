import { Router } from "express";
import { PrismaClient } from "@prisma/client";
import { error } from "console";
import { encrypt, compare } from '../helpper/handleBcryps.js';
const router = Router();
const prisma = new PrismaClient();

router.get("/usuarios", async (req,res) => {
    const usuarios = await prisma.usuarios.findMany()
    if (!usuarios) {
        return res.status(404).json({error : "Error al obtener usuarios"})
    }
    return res.json(usuarios)
})

router.post("/usuarios", async (req,res) =>{
    const {Contrasena} = req.body
    const ContraseñaHasheada = await encrypt(Contrasena)
    req.body.Contrasena = ContraseñaHasheada
    const nuevoUsuario = await prisma.usuarios.create(
        {
            data : req.body
          }
    );
    if (!nuevoUsuario) {
        return res.status(404).json({error : "No se pudo crear el usuario"})
    }
    return res.json(nuevoUsuario)
});

router.get('/usuarios/:id', async (req,res) =>{
    const usuario = await prisma.usuarios.findFirst({
        where : {
            Id : parseInt(req.params.id)
        },
        include : {
            periodos:true,
            grados : true,
            grupos : true,
        }
    });
    if (!usuario) {
        return res.status(404).json({error : "Usuario no encontrado"})
    }
    return res.json(usuario)
})

router.put('/usuarios/:id', async (req, res) => {
    const usuarioEditado = await prisma.usuarios.update({
        where : {
            Id : parseInt(req.params.id)
        },
        include : {
            periodos:true,
            grados : true,
            grupos : true,
        },
        data : {
            data : req.body
        }
    })
    if (!usuarioEditado) {
        return res.status(404).json({error : "Error al editar"})
    }
    return res.json(usuarioEditado)
} )

router.delete('/usuarios/:id', async (req,res) =>{
    const usuarioEliminado = await prisma.usuarios.delete({
        where:{
            Id: req.params.id
        }
    })
    if (!usuarioEliminado) {
        return res.status(404).json({error : "Error al eliminar usuario"})
    }
    return res.json('Usuario Eliminado')
})


export default router;