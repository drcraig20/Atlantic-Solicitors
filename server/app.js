/**
 * Main application file
 */

'use strict';

// Set default node environment to development
process.env.NODE_ENV = process.env.NODE_ENV || 'development';

var express = require('express');
var mongoose = require('mongoose');
var busboy = require('connect-busboy');
var config = require('./config/environment');
var throng = require('throng');
var WORKERS = process.env.WEB_CONCURRENCY || 2;

// Connect to database
function start(){
  mongoose.connect(config.mongo.uri, config.mongo.options);
  mongoose.connection.on('error', function(err) {
      console.error('MongoDB connection error: ' + err);
      process.exit(-1);
    }
  );
// Populate DB with sample data
  if(config.seedDB) { require('./config/seed'); }

// Setup server
  var app = express();
  app.use(busboy());
  var server = require('http').createServer(app);
  require('./config/express')(app);
  require('./routes')(app);

// Start server
  server.listen(config.port, config.ip, function () {
    console.log('Express server listening on %d, in %s mode', config.port, app.get('env'));
  });

// Expose app
  exports = module.exports = app;
}

console.log('Server currently using: %d WEB Workers!!!', WORKERS);


throng({
  workers: WORKERS,
  start: start
});
