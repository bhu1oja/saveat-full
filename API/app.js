const express = require("express");
const bodyParser = require("body-parser");
const mongoose = require("mongoose");
const path = require("path");
const passport = require("passport");
const session = require("express-session");

//init app
const app = express();

//db Config
const db = require("./config/db").mongoURI;

//connect to MongoDB
mongoose
  .connect(db, { useNewUrlParser: true, useCreateIndex: true })
  .then(() => console.log(db + "MongoDB connected"))
  .catch(err => console.log(err));

//set static public folder
app.use(express.static(path.join(__dirname, "public")));

//BodyParser
app.use(express.urlencoded({ extended: true, limit: "50mb" }));
// parse application/json
app.use(bodyParser.json());

//view engine
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");

// Express Session middleware
app.use(
  session({
    secret: "keyboard cat",
    resave: true,
    saveUninitialized: true
    //  cookie: { secure: true }
  })
);

//Express Mesasges
app.use(require("connect-flash")());
app.use(function(req, res, next) {
  res.locals.messages = require("express-messages")(req, res);
  next();
});

// Set global errors variable
app.locals.errors = null;

//import passport config
require("./config/passport");
//passport middleware
app.use(passport.initialize());
app.use(passport.session());

//set routes
app.use("/users", require("./routes/users.js"));
app.use("/", require("./routes/product"));
app.use("/", require("./routes/category"));
app.use("/", require("./routes/cart"));
app.use("/", require("./routes/favourite"));
app.use("/", require("./routes/mainBanner"));

//start server
const PORT = process.env.PORT || 8080;
const IP = "192.168.1.2";
app.listen(PORT, IP, (err, success) => {
  if (err) {
    console.log({
      status: 0,
      msg: `Server startig error on IP : ${IP} nad PORT : ${PORT}`
    });
  } else {
    console.log({ status: 1, msg: `Server started on ${PORT}  ${IP}` });
  }
});
