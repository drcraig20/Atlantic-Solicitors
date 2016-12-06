'use strict';
var path = require('path');             //used for file path
var fs = require('fs');           //File System - for file manipulation
var util = require('util');
var busboy = require('connect-busboy');
var config = require('../../config/environment');

var dir;


if(config.env == 'development'){
  dir = path.join(config.root, 'client','assets','images')
}
else if(config.env == 'production') {
  dir = path.join(config.root, 'public','assets','images')
}

exports.upload = function (req, res) {
  var arr;
  var fstream;
  var fileSize = 0;
  req.pipe(req.busboy);


  req.busboy.on('file', function (fieldname, file, filename, encoding, mimetype) {
    //uploaded file name, encoding, MIME type
    console.log('File [' + fieldname +']: filename:' + filename + ', encoding:' +
      encoding + ', MIME type:'+ mimetype);

    //uploaded file size
    file.on('data', function(data) {
      console.log('File [' + fieldname + '] got ' + data.length + ' bytes');
      fileSize = data.length;
      console.log("fileSize= " + fileSize);
    });

    file.on('end', function() {
      console.log('File [' + fieldname + '] ENDed');
      console.log("-------------------------");
    });

    /*
     populate array
     I am collecting file info in data read about the file. It may be more correct to
     read file data after the file has been saved to img folder i.e. after
     file.pipe(stream) completes the file size can be got using stats.size as shown
     below
     */
    arr= [{fieldname: fieldname, filename: filename, encoding: encoding, MIMEtype:
    mimetype}];

    //Path where image will be uploaded
    fstream = fs.createWriteStream(dir + '/' + filename);
    //create a writable stream

    file.pipe(fstream); //pipe the post data to the file

    //stream Ended - (data written) send the post response
    req.on('end', function () {
      res.writeHead(200, {"content-type":"text/html"});  //http response header
      // console.log(JSON.stringify(arr));
      res.end(JSON.stringify(arr)); //http response body - send json data
    });

    //Finished writing to stream
    fstream.on('finish', function () {
      console.log('Finished writing!');

      //Get file stats (including size) for file saved to server
      fs.stat(dir + '/' + filename, function(err, stats) {
        if(err)
          throw err;
        //if a file
        if (stats.isFile()) {
          console.log("It\'s a file & stats.size= " + JSON.stringify(stats));
          console.log("File size saved to server: " + stats.size);
          console.log("-----------------------");
        }
      });
    });

    // error
    fstream.on('error', function (err) {
      console.log(err);
    });
  });   // @END/ .req.busboy

};

exports.delete = function (req,res) {
  fs.unlink(dir+'\\'+req.query.name, function() {
    return res.status(200).json ({message:'file successfully deleted',status:'ok'});
  });
};

