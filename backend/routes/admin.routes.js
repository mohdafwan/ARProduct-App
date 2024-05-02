const express = require("express");
const admin = require("../middleware/admin.middleware");
const Order = require("../models/order.model");
const { Product } = require("../models/product.model");
const adminRouter = express.Router();

adminRouter.post("/admin/add-product", admin, async (req, res) => {
  try {
    const { threeName, name, description, images, price, quantity, category } =
      req.body; // Fix: use req.body instead of res.body
    let product = new Product({
      threeName,
      name,
      description,
      images,
      price,
      quantity,
      category,
    });
    product = await product.save();
    res.json(product);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

adminRouter.get("/admin/get-products", admin, async (req, res) => {
  try {
    const products = await Product.find({});
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

adminRouter.post("/admin/delete-product", admin, async (req, res) => {
  try {
    const { id } = req.body;
    let product = await Product.findByIdAndDelete(id);
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.get("/admin/get-orders", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    res.json(orders);
  } catch (error) {
    res.status(500).json({ error: e.message });
  }
});
adminRouter.post("/admin/change-order-status", admin, async (req, res) => {
  try {
    const { id, status } = req.body;
    let orders = await Order.findById(id);
    orders.status = status;
    orders = await orders.save();
    res.json(orders);
  } catch (error) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = adminRouter;
