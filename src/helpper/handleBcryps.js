import bcrypt from 'bcryptjs'

const encrypt = async (TextoPlano) => {
    const hash = await bcrypt.hash(TextoPlano,10)
    return hash;
}

const compare = async (contraseñaPlana, ContraseñaHasheada) => {
    return await bcrypt.compare(contraseñaPlana, ContraseñaHasheada)
}

export { encrypt, compare };
