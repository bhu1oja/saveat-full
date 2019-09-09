const multer = require("multer");

module.exports = function(destn) {
  try {
    const storage = multer.diskStorage({
      // Absolute path
      destination: function(req, file, callback) {
        callback(null, "./public/images/" + destn);
      },
      // Match the field name in the request body
      filename: function(req, file, callback) {
        callback(null, req.body.name + ".jpg");
      }
    });

    const fileFilter = (req, file, cb) => {
      // reject a file
      if (file.mimetype === "image/jpeg" || file.mimetype === "image/png") {
        cb(null, true);
      } else {
        cb(null, false);
      }
    };

    const upload = multer({
      storage: storage,
      limits: {
        fileSize: 1024 * 1024 * 5
      },
      fileFilter: fileFilter
    });
    return upload;
  } catch (ex) {
    console.log("Error :\n" + ex);
  }
};
