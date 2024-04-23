const express = require("express");
const auth = require("../middleware/auth.middleware");
const { Product } = require("../models/product.model");
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
productRouter.post("/api/products/rate-product", auth, async (req, res) => {
  try {
    const { id, rating } = req.body;
    let product = await Product.findById(id);

    // Check if product and product.rating exist and are arrays
    if (product && Array.isArray(product.rating)) {
      let i = 0;
      while (i < product.rating.length) {
        if (product.rating[i].userId == req.user) {
          product.rating.splice(i, 1);
          break;
        }
        i++;
      }
      const ratingSchema = { userId: req.user, rating };
      product.rating.push(ratingSchema);
      product = await product.save();
      res.json(product);
      console.log(product);
    } else {
      res.status(404).json({ error: "Product or product ratings not found" });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

productRouter.get("/api/products/deal-of-day", auth, async (req, res) => {
  try {
    let products = await Product.find({});

    products = products.sort((a, b) => {
      let aSum,
        bSum = 0;

      for (let i = 0; i < a.rating.length; i++) {
        aSum += a.rating[i].rating;
      }
      for (let i = 0; i < b.rating.length; i++) {
        bSum += b.rating[i].rating;
      }
      return aSum - bSum;
    });

    res.json(products[0]);
  } catch (error) {
    res.status(500).json({
      error: error.message,
    });
  }
});

module.exports = productRouter;
