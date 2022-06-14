import db from "../db.js";

async function verifyToken(token){
    return db.query(`SELECT * FROM sessions WHERE token = $1`, [token]);
}

const sessionsRepository = {
    verifyToken,
}

export default sessionsRepository;