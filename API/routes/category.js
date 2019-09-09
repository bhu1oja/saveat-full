const express = require("express");
const router = express.Router();
const path = require("path");

//include product model
const Category = require("../models/Category");

//include upload middleware
var upload = require("../includes/uploadMiddleware");

//get categery for API
router.get("/API-categories", (req, res) => {
  var count;
  Category.count((err, c) => {
    count = c;
  });
  Category.find((err, category) => {
    if (err) {
      throw err;
    }
    res.json({ count: count, category: category });
    res.end();
  });
});

//get categery for web admin
router.get("/categories", (req, res) => {
  var count;
  Category.count((err, c) => {
    count = c;
  });
  Category.find((err, category) => {
    if (err) {
      throw err;
    }
    res.render("category/view", {
      count: count,
      category: category
    });
  });
});

//get add category
router.get("/category-add", (Req, res) => {
  res.render("category/add");
});

//Post Category
router.post(
  "/category-add",
  upload("category").single("categoryImage"),
  (req, res) => {
    const targetPath = path.join("/images/category/" + req.body.name + ".jpg");
    var { name } = req.body;
    var category = new Category({
      name: name,
      categoryImage: targetPath
    });
    Category.findOne({ name: name }, (err, v) => {
      if (v) {
        req.flash("danger", `(${name}) alerady exists!`);
        res.render("category/add");
      } else {
        category.save(err => {
          if (err) {
            throw err;
          }
          req.flash("success", "category added!");
          res.redirect("/categories");
        });
      }
    });
  }
);

//Edit  category page
router.get("/category-edit/:id", (req, res) => {
  Category.findById(req.params.id, (err, category) => {
    if (err) {
      throw err;
    }
    res.render("category/edit", {
      category: category
    });
  });
});

//post edit-category
router.post("/category-edit/:id", (req, res) => {
  var name = req.body.name;
  var id = req.params.id;

  Category.findById(id, (err, category) => {
    if (err) {
      console.log(err);
    }
    category.name = name;
    category
      .save()
      .then(result => {
        req.flash("success", `Successgully edited!!!! name : (${name})`);
        res.redirect("/categories");
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
router.get("/category-delete/:id", (req, res) => {
  Category.findByIdAndRemove(req.params.id, err => {
    if (err) return err;
    req.flash("success", `category deleted!`);
    res.redirect("/categories");
  });
});
module.exports = router;
