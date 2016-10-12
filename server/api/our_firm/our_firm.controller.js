'use strict';

var _ = require('lodash');
var OurFirm = require('./our_firm.model');

// Get list of our_firms
exports.index = function(req, res) {
  OurFirm.find(function (err, our_firms) {
    if(err) { return handleError(res, err); }
    return res.status(200).json(our_firms);
  });
};

// Get a single our_firm
exports.show = function(req, res) {
  OurFirm.findById(req.params.id, function (err, our_firm) {
    if(err) { return handleError(res, err); }
    if(!our_firm) { return res.status(404).send('Not Found'); }
    return res.json(our_firm);
  });
};

// Creates a new our_firm in the DB.
exports.create = function(req, res) {
  OurFirm.create(req.body, function(err, our_firm) {
    if(err) { return handleError(res, err); }
    return res.status(201).json(our_firm);
  });
};

// Updates an existing our_firm in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  OurFirm.findById(req.params.id, function (err, our_firm) {
    if (err) { return handleError(res, err); }
    if(!our_firm) { return res.status(404).send('Not Found'); }
    var updated = _.merge(our_firm, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.status(200).json(our_firm);
    });
  });
};

// Deletes a our_firm from the DB.
exports.destroy = function(req, res) {
  OurFirm.findById(req.params.id, function (err, our_firm) {
    if(err) { return handleError(res, err); }
    if(!our_firm) { return res.status(404).send('Not Found'); }
    our_firm.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.status(204).send('No Content');
    });
  });
};

function handleError(res, err) {
  return res.status(500).send(err);
}