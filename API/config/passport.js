const localStrategy = require("passport-local").Strategy;
const bcrypt = require("bcryptjs");

//import user model
const User = require("../models/User");

module.exports = passport => {
  passport.use(
    new localStrategy((email, password, done) => {
      User.findOne({ email: email }, (err, user) => {
        if (err) {
          console.log(err);
        }
        if (!user) {
          return done(null, false, { error: "no user found" });
        }

        bcrypt.compare(password, user.password, (err, isMatch) => {
          if (err) {
            console.log(err);
          }
          if (isMatch) {
            return done(null, user);
          } else {
            return done(null, false, { error: "Wrong password" });
          }
        });
      });
    })
  );

  passport.serializeUser((user, done) => {
    done(null, user.id);
  });

  passport.deserializeUser((id, done) => {
    User.findById(id, (err, user) => {
      done(err, user);
    });
  });
};
