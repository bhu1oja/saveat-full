const mongoose = require("mongoose");
const FavouriteSchema = new mongoose.Schema({
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
  productPrice: {
    type: String,
    required: true
  },
  productDiscountPrice: {
    type: String,
    required: true
  },
  liked: {
    type: Boolean,
    required: true
  }
});
module.exports = mongoose.model("Favourite", FavouriteSchema);
