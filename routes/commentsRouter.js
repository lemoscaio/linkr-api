import { Router } from "express"

import { listComments, commentsCounter, updateComment } from "../controllers/commentsController.js"
import { tokenValidation } from "../middlewares/tokenValidation.js"
import updatePostSchema from "../schemas/updatePostSchema.js"
import { validateSchema } from "../middlewares/schemaValidator.js"

const commentsRouter = Router()

commentsRouter.get("/comments/:postId", listComments)
commentsRouter.get("/comments/counter/:postId", commentsCounter)
commentsRouter.put("/comments/:postId",tokenValidation,  validateSchema(updatePostSchema), updateComment)

export default commentsRouter