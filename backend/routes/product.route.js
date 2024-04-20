const express = require("express");
const auth = require("../middleware/auth.middleware");
const Product = require("../models/product.model");
const productRouter = express.Router();

productRouter.get("/api/products/homescreen", auth, async (req, res) => {
  try {
    const homeProducts = await Product.find();
    res.json(homeProducts);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

productRouter.get("/api/products", auth, async (req, res) => {
  try {
    const products = await Product.find({ category: req.query.category });
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: error.message });
    console.log(error);
  }
});
productRouter.get("/api/products/search/:name", auth, async (req, res) => {
  try {
    const products = await Product.find({
      name: { $regex: req.params.name, $options: "s" },
    });
    res.json(products);
    console.log(products);
  } catch (error) {
    res.status(500).json({ error: error.message });
    console.log(error);
  }
});

module.exports = productRouter;
