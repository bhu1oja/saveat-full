const express = require("express");
const router = express.Router();

//import Favourite model
const Favourite = require("../models/Favourite");

//import product model
const Product = require("../models/Product");

//get favourite
router.get("/favourites/:id", (req, res) => {
  var id = req.params.id;
  console.log("UID" + id);
  Favourite.find({ userID: id, liked: true })
    .exec()
    .then(fav => {
      res.json({
        status: 1,
        data: fav,
        msg: " success"
      });
    })
    .catch(err => {
      res.json({ status: 0, data: err, msg: " error" });
    });
});

//get Single product favourite
router.get("/favourite-single-product/:uid/:pid", (req, res) => {
  var uid = req.params.uid;
  var pid = req.params.pid;

  Favourite.find({ userID: uid, productID: pid, liked: true })
    .exec()
    .then(fav => {
      res.json({
        status: 1,
        data: fav,
        msg: " success"
      });
    })
    .catch(err => {
      res.json({ status: 0, data: err, msg: " error" });
    });
});

//post favourite
router.post("/favourite-add", (req, res) => {
  var {
    userID,
    productID,
    productName,
    productImage,
    productPrice,
    productDiscountPrice
  } = req.body;
  Favourite.findOne({ liked: false, productID: productID, userID: userID })
    .exec()
    .then(fav => {
      if (fav) {
        fav.liked = true;
        fav
          .save()
          .then(result => {
            res.json({
              status: 1,
              data: result,
              msg: " Succesfully added to favourite"
            });
          })
          .catch(err => {
            console.log(err);
            res.json({
              status: 0,
              data: err,
              msg: " failed to add to favourite"
            });
          });
      } else {
        Favourite.findOne({ liked: true, productID: productID, userID: userID })
          .exec()
          .then(fav => {
            if (fav) {
              res.json({
                status: 1,
                data: fav,
                msg: " You have liked it before"
              });
            } else {
              var favourite = new Favourite({
                userID: userID,
                productID: productID,
                liked: true,
                productName: productName,
                productImage: productImage,
                productPrice: productPrice,
                productDiscountPrice: productDiscountPrice
              });

              favourite
                .save()
                .then(result => {
                  res.json({
                    status: 1,
                    data: result,
                    msg: " Succesfully added to favourite"
                  });
                })
                .catch(err => {
                  console.log(err);
                  res.json({ status: 0, data: err, msg: " error" });
                });
            }
          });
      }
    })
    .catch(err => {
      console.log(err);
      res.json({ status: 0, data: err, msg: " error" });
    });
});

//remove favourite
router.post("/favourite-remove", (req, res) => {
  var { userID, productID } = req.body;
  Favourite.findOne({ userID: userID, productID: productID, liked: true })
    .exec()
    .then(fav => {
      fav.liked = false;
      fav
        .save()
        .then(result => {
          res.json({ status: 1, data: result, msg: " success" });
        })
        .catch(err => {
          console.log(err);
          res.json({ status: 0, data: err, msg: " error" });
        });
    })
    .catch(err => {
      console.log(err);
      res.json({ status: 0, data: err, msg: " error" });
    });
});
module.exports = router;
