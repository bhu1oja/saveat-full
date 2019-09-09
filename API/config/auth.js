exports.isUser = function(req, res, next) {
  if (req.isAuthenticated()) {
    next();
  } else {
    res.send({ error: "Please login" });
  }
};

exports.isVendor = function(req, res, next) {
  if (req.isAuthenticated() && res.locals.user.vendor == 1) {
    next();
  } else {
    res.send({ error: "Please login" });
  }
};

exports.isAdmin = function(req, res, next) {
  if (req.isAuthenticated() && res.locals.user.admin == 1) {
    next();
  } else {
    res.send({ error: "Please login" });
  }
};
