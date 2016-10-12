'use strict';

var _ = require('lodash');
var Mute = require('immutable');
var AboutUs = require('./aboutUs.model');

// Get list of aboutUss
exports.index = function(req, res) {
  AboutUs.find(function (err, result) {
    var aboutUss = Mute.List(result);
    if(err) { return handleError(res, err); }
    return res.status(200).json(aboutUss);
  });
};

// Get a single aboutUs
exports.show = function(req, res) {
  AboutUs.findById(req.params.id, function (err, aboutUs) {
    if(err) { return handleError(res, err); }
    if(!aboutUs) { return res.status(404).send('Not Found'); }
    return res.json(aboutUs);
  });
};

// Creates a new aboutUs in the DB.
exports.create = function(req, res) {
  AboutUs.create(req.body, function(err, aboutUs) {
    if(err) { return handleError(res, err); }
    return res.status(201).json(aboutUs);
  });
};

// Updates an existing aboutUs in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  AboutUs.findById(req.params.id, function (err, aboutUs) {
    if (err) { return handleError(res, err); }
    if(!aboutUs) { return res.status(404).send('Not Found'); }
    var updated = _.merge(aboutUs, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.status(200).json(aboutUs);
    });
  });
};

// Deletes a aboutUs from the DB.
exports.destroy = function(req, res) {
  AboutUs.findById(req.params.id, function (err, aboutUs) {
    if(err) { return handleError(res, err); }
    if(!aboutUs) { return res.status(404).send('Not Found'); }
    aboutUs.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.status(204).send('No Content');
    });
  });
};

function handleError(res, err) {
  return res.status(500).send(err);
}
