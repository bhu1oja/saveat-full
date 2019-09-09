const express = require("express");
const router = express.Router();
const path = require("path");
const multer = require("multer");

//include product model
const MainBanner = require("../models/MainBanner");

//include upload middleware
var upload = require("../includes/uploadMiddleware");

//get banner for API
router.get("/API-banners", (req, res) => {
  var count;
  MainBanner.countDocuments((err, c) => {
    count = c;
  });
  MainBanner.find((err, mainBanner) => {
    if (err) {
      throw err;
    }
    res.json({ count: count, mainBanner: mainBanner });
  });
});

//get banner for web admin
router.get("/banners", (req, res) => {
  var count;
  MainBanner.countDocuments((err, c) => {
    count = c;
  });
  MainBanner.find((err, mainBanner) => {
    if (err) {
      throw err;
    }
    res.render("mainBanner/view", {
      count: count,
      mainBanner: mainBanner
    });
  });
});

//get add category
router.get("/banner-add", (Req, res) => {
  res.render("mainBanner/add");
});

//index bannerupload
router.post(
  "/upload-banner",
  upload("banner").single("bannerImage"),
  (req, res) => {
    const targetPath = path.join("/images/banner/" + req.body.name + ".jpg");
    var mainBanner = new MainBanner({
      name: req.body.name,
      bannerImage: targetPath
    });
    mainBanner
      .save()
      .then(result => {
        res.redirect("/banners");
      })
      .catch(err => {
        console.log(err);
        res.status(500).json({
          error: err
        });
      });
  }
);

//Edit  category page
router.get("/banner-edit/:id", (req, res) => {
  MainBanner.findById(req.params.id, (err, mainBanner) => {
    if (err) {
      throw err;
    }
    res.render("mainBanner/edit", {
      mainBanner: mainBanner
    });
  });
});

//post edit-category
router.post("/banner-edit/:id", (req, res) => {
  var name = req.body.name;
  var id = req.params.id;

  MainBanner.findById(id, (err, mainBanner) => {
    if (err) {
      console.log(err);
    }
    mainBanner.name = name;
    mainBanner
      .save()
      .then(result => {
        req.flash("success", `Successgully edited!!!! name : (${name})`);
        res.redirect("/banners");
      })
      .catch(err => {
        console.log(err);
        res.status(500).json({
          error: err
        });
      });
  });
});

//Delete category page
router.get("/banner-delete/:id", (req, res) => {
  MainBanner.findByIdAndRemove(req.params.id, err => {
    if (err) return err;
    req.flash("success", `category deleted!`);
    res.redirect("/banners");
  });
});
module.exports = router;
