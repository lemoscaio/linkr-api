import {Router} from 'express';

import {validateSchema} from '../middlewares/schemaValidator.js';

import publishSchema from "../schemas/publishSchema.js";

const publishRouter = Router();
console.log(" Passando pela rota de publicação ");

publishRouter.post("/publish", validateSchema(publishSchema), createPublish);


export default publishRouter;