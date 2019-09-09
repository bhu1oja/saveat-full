const express = require("express");
const router = express.Router();
const path = require("path");

//include product model
const Product = require("../models/Product");

//include category model
const Category = require("../models/Category");

//include upload middleware
var upload = require("../includes/uploadMiddleware");

//get product
router.get("/products", async (req, res, next) => {
  Product.find()
    .exec()
    .then(products => {
      res.json({ products });
      res.end();
    })
    .catch(err => {
      console.log(err);
      res.status(500).json({
        error: err
      });
    });
});

//getSingle product
router.get("/product/:id", (req, res) => {
  Product.findById(req.params.id)
    .exec()
    .then(product => {
      res.json({ product });
    })
    .catch(err => {
      console.log(err);
      res.status(500).json({
        error: err
      });
    });
});

//add product
router.post(
  "/product-add",
  upload("product").single("productImage"),
  (req, res) => {
    var {
      name,
      description,
      price,
      discount,
      bestBuyDate,
      vendorID,
      category
    } = req.body;
    var temp = req.body.name;
    var slug = temp;
    const targetPath = path.join("/images/product/" + slug + ".jpg");
    var product = new Product({
      name: name,
      slug: slug,
      description: description,
      price: price,
      discount: discount,
      bestBuyDate: bestBuyDate,
      productImage: targetPath,
      vendorID: vendorID,
      category: category
    });
    product
      .save()
      .then(result => {
        res.json({
          status: 1,
          data: result,
          msg: " Product added successfully"
        });
      })
      .catch(err => {
        res.json(err);
      });
  }
);

//get product by category
router.get("/product/category/:category", (req, res) => {
  var myCategory = req.params.category;

  Product.find({ category: myCategory })
    .exec()
    .then(product => {
      res.json({ product });
    })
    .catch(err => {
      console.log(err);
      res.status(500).json({
        error: err
      });
    });
});

/***
 * vendor section API
 */

//get product by vendor
router.get("/product/vendor/:vendorID", (req, res) => {
  var vendorId = req.params.vendorID;

  Product.find({ vendorID: vendorId })
    .exec()
    .then(product => {
      res.json({ product });
    })
    .catch(err => {
      console.log(err);
      res.status(500).json({
        error: err
      });
    });
});
//edit product
router.post("/product-edit/:id", (req, res) => {
  var { name, description, price, discount, bestBuyDate } = req.body;
  var id = req.params.id;
  Product.findById(id, (err, product) => {
    if (err) {
      console.log(err);
    }
    product.name = name;
    product.description = description;
    product.price = price;
    product.discount = discount;
    product.bestBuyDate = bestBuyDate;

    product
      .save()
      .then(result => {
        res.json({ result });
      })
      .catch(err => {
        console.log(err);
        res.status(500).json({
          err
        });
      });
  });
});

//Delete  product
router.get("/product-delete/:id", (req, res) => {
  Product.findByIdAndRemove(req.params.id, err => {
    if (err)
      res.json({
        status: 0,
        msg: " Unable to delete product"
      });
    res.json({
      status: 1,
      msg: " Product deleted successfully"
    });
  });
});

module.exports = router;
