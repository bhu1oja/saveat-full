const express = require("express");
const router = express.Router();

//import Cart model
const Cart = require("../models/Cart");

//import Cart Product
const Product = require("../models/Product");
//getCart
router.get("/cart/:id", (req, res) => {
  Cart.find({ userID: req.params.id, isPaid: false })
    .exec()
    .then(cart => {
      res.json({
        status: 1,
        cart: cart,
        msg: " cart data fetched successfully"
      });
    })
    .catch(err => {
      res.json({ status: 0, data: err, msg: " error" });
    });
});
//add to cart
router.post("/cart-add/:id", async (req, res) => {
  var id = req.params.id;
  var {
    userID,
    productID,
    productName,
    productImage,
    productCategory,
    quantity,
    total,
    vendorID,
    vendorName
  } = req.body;
  Cart.findOne(
    { productID: id, userID: userID, isPaid: false },
    (err, cartData) => {
      if (!cartData) {
        const cart = new Cart({
          userID: userID,
          productID: productID,
          quantity: quantity,
          productName: productName,
          productImage: productImage,
          productCategory: productCategory,
          total: total,
          vendorID: vendorID,
          vendorName: vendorName,
          isPaid: false,
          isPickedUp: false
        });
        cart
          .save()
          .then(result => {
            res.json({
              status: 1,
              data: result,
              msg: " successfully added to cart"
            });
          })
          .catch(err => {
            res.json({
              status: 0,
              data: err,
              msg: " error while adding in cart"
            });
          });
      } else {
        res.json({
          status: 1,
          msg: "already in cart" + quantity
        });
      }
    }
  );
});

router.post("/cart-increase/:id/:uID", async (req, res) => {
  var id = req.params.id;
  var userID = req.params.uID;
  Cart.findOne(
    { productID: id, userID: userID, isPaid: false },
    (er, update) => {
      if (er)
        return res.json({
          status: 0,
          data: er,
          msg: " error while updating data on cart"
        });

      var updatedQuantity = update.quantity + 1;
      update.quantity = updatedQuantity;
      update
        .save()
        .then(result => {
          res.json({
            status: 1,
            data: result,
            msg: " successfully updated" + update.quantity
          });
        })
        .catch(err => {
          console.log(err);
          res.json({ status: 0, data: err, msg: " error on update" });
        });
    }
  );
});

router.post("/cart-decrease/:id/:uID", async (req, res) => {
  var id = req.params.id;
  var userID = req.params.uID;
  Cart.findOne(
    { productID: id, userID: userID, isPaid: false },
    (er, update) => {
      if (er)
        return res.json({
          status: 0,
          data: er,
          msg: " error while updating data on cart"
        });
      var updatedQuantity = update.quantity - 1;
      update.quantity = updatedQuantity;
      update
        .save()
        .then(result => {
          res.json({
            status: 1,
            data: result,
            msg: " successfully updated" + update.quantity
          });
        })
        .catch(err => {
          console.log(err);
          res.json({ status: 0, data: err, msg: " error on update" });
        });
    }
  );
});
//checkout
router.post("/checkcart/:id", (req, res) => {
  var id = req.params.id;
  Cart.find({ userID: id, isPaid: false }).updateMany(
    {},
    { $set: { isPaid: true } },
    { multi: true },
    (err, checkout) => {
      if (err) return res.json({ status: 0, data: err, msg: " err" });
      else {
        res.json({ status: 1, data: checkout, msg: " success" });
      }
    }
  );
});
//generate QR of order
router.get("/generate-cart-qr/:uid", (req, res) => {
  var uid = req.params.uid;
  Cart.find({ userID: uid, isPaid: true, isPickedUp: false }, (err, result) => {
    if (err) {
      res.json({ status: 0, data: err, msg: "Error on fetching QR data" });
    } else {
      res.json({
        status: 1,
        data: result,
        msg: "QR data successfully fetched"
      });
    }
  });
});

module.exports = router;
