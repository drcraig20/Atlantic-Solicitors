'use strict';

var _ = require('lodash');
var Mute = require('immutable');
var Contactus = require('./contactus.model');

// Get list of contactuss
exports.index = function(req, res) {
  Contactus.find(function (err, result) {
    if(err) { return handleError(res, err); }
    var contactus = Mute.List(result);
    return res.status(200).json(contactus);
  });
};

// Get a single contactus
exports.show = function(req, res) {
  Contactus.findById(req.params.id, function (err, contactus) {
    if(err) { return handleError(res, err); }
    if(!contactus) { return res.status(404).send('Not Found'); }
    return res.json(contactus);
  });
};

// Creates a new contactus in the DB.
exports.create = function(req, res) {
  Contactus.create(req.body, function(err, contactus) {
    if(err) { return handleError(res, err); }
    return res.status(201).json(contactus);
  });
};

// Updates an existing contactus in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Contactus.findById(req.params.id, function (err, contactus) {
    if (err) { return handleError(res, err); }
    if(!contactus) { return res.status(404).send('Not Found'); }
    var updated = _.merge(contactus, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.status(200).json(contactus);
    });
  });
};

// Deletes a contactus from the DB.
exports.destroy = function(req, res) {
  Contactus.findById(req.params.id, function (err, contactus) {
    if(err) { return handleError(res, err); }
    if(!contactus) { return res.status(404).send('Not Found'); }
    contactus.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.status(204).send('No Content');
    });
  });
};

function handleError(res, err) {
  return res.status(500).send(err);
}
