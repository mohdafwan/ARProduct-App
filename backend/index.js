/*
  === Welcome to ARPODUCTS! ===
  
  Hey there, fellow innovators! 🚀
  
  This is where the magic begins,
  where pixels dance and ideas shine! 💡
  
  Proudly crafted with passion and caffeine by:
  MOHD AFWAN 👨‍💻
  
  Let's embark on this journey together,
  shaping the digital landscape, one line at a time. 🌟
  
  Cheers to endless possibilities! 🥂
*/

const express = require("express");
const mongoose = require("mongoose");
const userRouter = require("./routes/auth.routes");
const adminRouter = require("./routes/admin.routes");
const productRouter = require("./routes/product.routes");
const duserRouter = require("./routes/user.routes");

const PORT = process.env.PORT || 3000;
const app = express();
const DB = "mongodb://username:password@hostname:port/database"; // Replace username, password, hostname, port, and database with your MongoDB credentials and database details.
app.use(express.json());
app.use(userRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(duserRouter);

mongoose
  .connect(DB)
  .then(() => {
    console.log("DB Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server Listen on Port:http://localhost:${PORT}`);
});
