'use strict';

var _ = require('lodash');
var Muted = require('immutable');
var Solicitor = require('./solicitor.model');

// Get list of solicitors
exports.index = function(req, res) {
  Solicitor.find(function (err, solicitors) {
    if(err) { return handleError(res, err); }
    return res.status(200).json(solicitors);
  });
};


// Get details to populate the web page of homepage
exports.getDetails = function(req, res) {
  var condition = {
    mode:req.query.type
  };

  Solicitor.findOne(condition,function (err, details) {
    if(err) { return handleError(res, err); }
    if(!details) { return res.status(404).send('Not Found'); }
    return res.json(Muted.fromJS(details));
  });
};
// Get a single solicitor
exports.show = function(req, res) {
    Solicitor.findById(req.params.id, function (err, solicitor) {
      if(err) { return handleError(res, err); }
      if(!solicitor) { return res.status(404).send('Not Found'); }
      return res.json(solicitor);
    });
};

// Creates a new solicitor in the DB.
exports.create = function(req, res) {
  Solicitor.create(req.body, function(err, solicitor) {
    if(err) { return handleError(res, err); }
    return res.status(201).json(solicitor);
  });
};

// Updates an existing solicitor in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Solicitor.findById(req.params.id, function (err, solicitor) {
    if (err) { return handleError(res, err); }
    if(!solicitor) { return res.status(404).send('Not Found'); }
    var updated = _.merge(solicitor, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.status(200).json(solicitor);
    });
  });
};

// Deletes a solicitor from the DB.
exports.destroy = function(req, res) {
  Solicitor.findById(req.params.id, function (err, solicitor) {
    if(err) { return handleError(res, err); }
    if(!solicitor) { return res.status(404).send('Not Found'); }
    solicitor.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.status(204).send('No Content');
    });
  });
};

function handleError(res, err) {
  return res.status(500).send(err);
}
