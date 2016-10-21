'use strict';

var _ = require('lodash');
var ServiceContent = require('./serviceContent.model');

// Get list of serviceContents
exports.index = function(req, res) {
  ServiceContent.find(function (err, serviceContents) {
    if(err) { return handleError(res, err); }
    return res.status(200).json(serviceContents);
  });
};

// Get a single serviceContent
exports.show = function(req, res) {
  ServiceContent.findById(req.params.id, function (err, serviceContent) {
    if(err) { return handleError(res, err); }
    if(!serviceContent) { return res.status(404).send('Not Found'); }
    return res.json(serviceContent);
  });
};

// Creates a new serviceContent in the DB.
exports.create = function(req, res) {
  ServiceContent.create(req.body, function(err, serviceContent) {
    if(err) { return handleError(res, err); }
    return res.status(201).json(serviceContent);
  });
};

// Updates an existing serviceContent in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  ServiceContent.findById(req.params.id, function (err, serviceContent) {
    if (err) { return handleError(res, err); }
    if(!serviceContent) { return res.status(404).send('Not Found'); }
    var updated = _.merge(serviceContent, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.status(200).json(serviceContent);
    });
  });
};

// Deletes a serviceContent from the DB.
exports.destroy = function(req, res) {
  ServiceContent.findById(req.params.id, function (err, serviceContent) {
    if(err) { return handleError(res, err); }
    if(!serviceContent) { return res.status(404).send('Not Found'); }
    serviceContent.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.status(204).send('No Content');
    });
  });
};

function handleError(res, err) {
  return res.status(500).send(err);
}