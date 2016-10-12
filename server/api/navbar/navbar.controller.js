'use strict';

var _ = require('lodash');
var Mute = require('immutable');
var Navbar = require('./navbar.model');
var Testimony = require('./testimonial.model');

// Get list of navbars
exports.index = function(req, res) {
  Navbar.find(function (err, result) {
    var navbars = Mute.List(result);
    if(err) { return handleError(res, err); }
    return res.status(200).json(navbars);
  });
};

// Get a single navbar
exports.show = function(req, res) {
  Navbar.findById(req.params.id, function (err, navbar) {
    if(err) { return handleError(res, err); }
    if(!navbar) { return res.status(404).send('Not Found'); }
    return res.json(navbar);
  });
};

// Creates a new navbar in the DB.
exports.create = function(req, res) {
  Navbar.create(req.body, function(err, navbar) {
    if(err) { return handleError(res, err); }
    return res.status(201).json(navbar);
  });
};

// Updates an existing navbar in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Navbar.findById(req.params.id, function (err, navbar) {
    if (err) { return handleError(res, err); }
    if(!navbar) { return res.status(404).send('Not Found'); }
    var updated = _.merge(navbar, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.status(200).json(navbar);
    });
  });
};

// Deletes a navbar from the DB.
exports.destroy = function(req, res) {
  Navbar.findById(req.params.id, function (err, navbar) {
    if(err) { return handleError(res, err); }
    if(!navbar) { return res.status(404).send('Not Found'); }
    navbar.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.status(204).send('No Content');
    });
  });
};

//get list of latest testimonials
exports.testimonials = function(req, res) {
  Testimony.find().sort('dt_created').limit(5).exec(function (err, result) {
    var testimonial = Mute.List(result);
    if(err) { return handleError(res, err); }
    return res.status(200).json(testimonial);
  });
};

function handleError(res, err) {
  return res.status(500).send(err);
}
