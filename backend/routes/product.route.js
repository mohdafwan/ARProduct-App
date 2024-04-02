const express = require("express");
const auth = require("../middleware/auth.middleware");
const Product = require("../models/product.model");
const productRouter = express.Router();

productRouter.get("/api/products", auth, async (req, res) => {
  try {
    const products = await Product.find({ category: req.query.category });
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: error.message });
    console.log(error);
  }
});

module.exports = productRouter;
