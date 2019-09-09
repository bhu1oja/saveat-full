const mongoose = require("mongoose");
const MainBannerSchema = mongoose.Schema({
  name: {
    type: String,
    required: true
  },
  bannerImage: {
    type: String,
    required: true
  }
});

const MainBanner = mongoose.model("MainBanner", MainBannerSchema);
module.exports = MainBanner;
