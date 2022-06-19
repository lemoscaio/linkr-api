import { Router } from "express";

import { tokenValidation } from "../middlewares/tokenValidation.js";

import { getUserBySearch } from "../controllers/userController.js";

const searchBarRouter = Router();

searchBarRouter.get("/search/:name", tokenValidation, getUserBySearch);

export default searchBarRouter;