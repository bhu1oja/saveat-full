const mongoose = require("mongoose");
const CartSchema = new mongoose.Schema({
  userID: {
    type: String,
    required: true
  },
  productID: {
    type: String,
    required: true
  },
  productName: {
    type: String,
    required: true
  },
  productImage: {
    type: String,
    required: true
  },
  productCategory: {
    type: String,
    required: true
  },
  quantity: {
    type: Number,
    required: true
  },
  total: {
    type: Number,
    required: true
  },
  vendorID: {
    type: String,
    required: true
  },
  vendorName: {
    type: String,
    required: true
  },
  isPaid: {
    type: Boolean,
    default: false
  },
  isPickedUp: {
    type: Boolean,
    default: false
  }
});
module.exports = mongoose.model("Cart", CartSchema);
