var express = require("express");
var router = express.Router();
var passport = require("passport");
var bcrypt = require("bcryptjs");

// Get Users model
var User = require("../models/User");

/*
 * POST register
 */
router.post("/register", function(req, res) {
  var name = req.body.name;
  var email = req.body.email;
  var password = req.body.password;
  var type = req.body.type;

  if (name === "" || email === "" || password === "" || type === "") {
    res.json({ status: 0, data: "error", msg: " Enter all fields" });
  } else {
    User.findOne({ email: email }, function(err, user) {
      if (err) console.log(err);

      if (user) {
        res.json({ status: 0, data: user.email, msg: " User already exists" });
      } else {
        var user = new User({
          name: name,
          email: email,
          password: password,
          type: type
        });
        //hash password
        bcrypt.genSalt(10, function(err, salt) {
          bcrypt.hash(user.password, salt, function(err, hash) {
            if (err) {
              res.json({
                status: 0,
                data: err,
                msg: " error while hashing password"
              });
            }

            user.password = hash;

            user.save(function(err) {
              if (err) {
                res.json({ status: 0, data: err, msg: " error" });
              } else {
                res.json({
                  status: 1,
                  data: user,
                  msg: `successfully registered as: ${type}`
                });
              }
            });
          });
        });
      }
    });
  }
});

/*
 * POST login
 */
router.post("/login", function(req, res) {
  var { email, password } = req.body;
  if (email === "" || password === "") {
    res.json({ status: 0, data: "error", msg: " Enter all fields!!!" });
  } else {
    User.findOne({ email: email }, (err, user) => {
      if (err) {
        res.json({ status: 0, message: err });
      }
      if (!user) {
        res.json({ status: 0, msg: " User not found" });
      } else {
        bcrypt.compare(password, user.password, (err, isMatch) => {
          if (err) {
            res.json({ status: 0, data: err, msg: " error" });
          } else {
            if (!isMatch) {
              res.json({
                status: 0,
                data: isMatch,
                msg: " Password didnt match"
              });
            } else {
              res.json({
                status: 1,
                data: {
                  id: user.id,
                  name: user.name,
                  email: user.email,
                  type: user.type
                },
                msg: "success"
              });
            }
          }
        });
      }
    });
  }
});

//find vendor by id
router.get("/profile/:id", (req, res) => {
  var userID = req.params.id;

  User.findOne({ _id: userID }, (err, usr) => {
    if (err)
      res.json({
        status: 0,
        data: err,
        msg: err
      });

    res.json({
      status: 1,
      user: { id: usr.id, name: usr.name, email: usr.email, type: usr.type },
      msg: "Profile fetched"
    });
  });
});

// Exports
module.exports = router;
