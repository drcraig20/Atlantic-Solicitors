/**
 * Created by DrCraig LawPav on 11/10/2016.
 */

var fs = require('fs');
var path = require('path');
var Muted = require('immutable');

exports.readDirectory = function(req,res) {
  var root ='';
  if (process.env.NODE_ENV == 'development')
  {
    root = path.normalize(__dirname + '/../../../client/assets/images');
  }
  else {
    root = path.normalize(__dirname + '/../../../public/assets/images');
  }
  fs.readdir(root, function(err, imageNames) {
    if (err) { return handleError(res, err); }
    return res.status(200).json(Muted.List(imageNames));
  });
};



function handleError(res, err) {
  return res.status(500).send(err);
}

