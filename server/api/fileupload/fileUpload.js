/**
 * Created by DrCraig LawPav on 11/22/2016.
 */
var express = require('express');
var app  = express();
var multer = require('multer');

var storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null,'./assets/images/')
  },
  filename: function (req, file, cb) {
    var datetimestamp = Date.now();
    cb(null, file.fieldname + '-' + datetimestamp + '.' + file.originalname.split('.')[file.originalname.split('.').length -1])
  }
});

exports.uploads = function(req, res) {
  upload(req,res,function(err){
    if(err) { return handleError(res, err); }
    return res.status(200).json('Upload Successful');
  })
};

var upload = multer({ //multer settings
  storage: storage
}).single('file');


function handleError(res, err) {
  return res.status(500).send(err);
}
