'use strict';

var _ = require('lodash');
var Testimonial = require('./testimonial.model');

// Get list of testimonials
exports.index = function(req, res) {
  Testimonial.find(function (err, testimonials) {
    if(err) { return handleError(res, err); }
    return res.status(200).json(testimonials);
  });
};

// Get a single testimonial
exports.show = function(req, res) {
  Testimonial.findById(req.params.id, function (err, testimonial) {
    if(err) { return handleError(res, err); }
    if(!testimonial) { return res.status(404).send('Not Found'); }
    return res.json(testimonial);
  });
};

// Creates a new testimonial in the DB.
exports.create = function(req, res) {
  Testimonial.create(req.body, function(err, testimonial) {
    if(err) { return handleError(res, err); }
    return res.status(201).json(testimonial);
  });
};

// Updates an existing testimonial in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Testimonial.findById(req.params.id, function (err, testimonial) {
    if (err) { return handleError(res, err); }
    if(!testimonial) { return res.status(404).send('Not Found'); }
    var updated = _.merge(testimonial, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.status(200).json(testimonial);
    });
  });
};

// Deletes a testimonial from the DB.
exports.destroy = function(req, res) {
  Testimonial.findById(req.params.id, function (err, testimonial) {
    if(err) { return handleError(res, err); }
    if(!testimonial) { return res.status(404).send('Not Found'); }
    testimonial.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.status(204).send('No Content');
    });
  });
};

function handleError(res, err) {
  return res.status(500).send(err);
}