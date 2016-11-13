/**
 * Main application routes
 */

'use strict';

var errors = require('./components/errors');
var path = require('path');

module.exports = function(app) {

  // Insert routes below
  app.use('/api/articles', require('./api/article'));
  app.use('/api/messages', require('./api/message'));
  app.use('/api/profiles', require('./api/profile'));
  app.use('/api/serviceContents', require('./api/serviceContent'));
  app.use('/api/services', require('./api/services'));
  app.use('/api/solicitors', require('./api/solicitor'));
  app.use('/api/contactUs', require('./api/contactus'));
  app.use('/api/our_firm', require('./api/our_firm'));
  app.use('/api/aboutUs', require('./api/aboutUs'));
  app.use('/api/navbars', require('./api/navbar'));
  app.use('/auth', require('./api/auth'));

  // All undefined asset or api routes should return a 404
  app.route('/:url(api|auth|components|app|bower_components|assets)/*')
   .get(errors[404]);

  // All other routes should redirect to the index.html
  app.route('/*')
    .get(function(req, res) {
      res.sendFile(path.resolve(app.get('appPath') + '/index.html'));
    });
};
