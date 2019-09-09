const mongoose = require("mongoose");

var ProductSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true
  },
  slug: {
    type: String,
    required: true
  },
  description: {
    type: String,
    required: true
  },
  price: {
    type: String,
    required: true
  },
  discount: {
    type: String,
    required: true
  },
  bestBuyDate: {
    type: String,
    required: true
  },
  category: {
    type: String,
    required: true
  },
  vendorID: {
    type: String,
    required: true
  },
  productImage: {
    type: String,
    required: true
  }
});

const Product = mongoose.model("Product", ProductSchema);
module.exports = Product;
