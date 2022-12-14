import express from "express";
import controller from "../controllers/consulta2";

const router = express.Router();

router.get("/:camasCasal",controller.ConsultaD);
router.get("/:cidade/:data",controller.ConsultaE);

export default router;