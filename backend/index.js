const express = require("express");
const mongoose = require("mongoose");
const userRouter = require("./routes/auth.routes");

const PORT = process.env.PORT || 3000;
const app = express();
const DB =
  "mongodb://afwan:afwan111@ac-kkun4ub-shard-00-00.rnmjgkn.mongodb.net:27017,ac-kkun4ub-shard-00-01.rnmjgkn.mongodb.net:27017,ac-kkun4ub-shard-00-02.rnmjgkn.mongodb.net:27017/?ssl=true&replicaSet=atlas-51itvz-shard-0&authSource=admin&retryWrites=true&w=majority&appName=Cluster1";

app.use(express.json());
app.use(userRouter);
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
