'use strict';
var express = require('express');
var fs = require('fs');
var path = require('path');
var config = require('../../config/environment');

var app = express();
var dir;
if(config.env == 'development'){
  dir = path.join(config.root, 'client','assets');
}
if(config.env == 'production'){
  dir = path.join(config.root, 'public','assets');
}

// config the uploader
var options = {
  tmpDir: path.join(dir,'tmp'),
  uploadDir : path.join(dir,'images'),
  uploadUrl: '/assets/images',
  // useSSL: true,
  maxPostSize: 11000000, // 11 MB
  minFileSize:  1,
  maxFileSize:  11000000, // 10 MB
  acceptFileTypes:  /.+/i,
  // Files not matched by this regular expression force a download dialog,
  // to prevent executing any scripts in the context of the service domain:
  inlineFileTypes:  /\.(gif|jpe?g|png)/i,
  imageTypes:  /\.(gif|jpe?g|png)/i,
  copyImgAsThumb : true, // required
  imageVersions :{
    maxWidth : 200,
    maxHeight : 200
  },
  accessControl: {
    allowOrigin: '*',
    allowMethods: 'OPTIONS, HEAD, GET, POST, PUT, DELETE',
    allowHeaders: 'Content-Type, Content-Range, Content-Disposition'
  },
  storage : {
    type : 'local'
  }
};
var uploader = require('blueimp-file-upload-expressjs')(options);
console.log(options);
  exports.get = function(req, res) {
    uploader.get(req, res, function (err,obj) {
    if(!err){
      res.send(JSON.stringify(obj));
    }
  });
  };


  exports.post = function(req, res) {
    uploader.post(req, res, function (error,obj, redirect) {
      if(!error)
      {
        res.send(JSON.stringify(obj));
      }
    });
  };


  exports.delete = function(req, res) {
    uploader.delete(req, res, function (err,obj) {
      if (err) {res.Json({error:err});}
      if (!err){res.send(JSON.stringify(obj));}
    });
  };




function handleError(res, err) {
  return res.status(500).send(err);
}
