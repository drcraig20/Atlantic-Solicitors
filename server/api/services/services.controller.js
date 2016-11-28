'use strict';

var _ = require('lodash');
var Muted = require('immutable');
var Services = require('./services.model');

// Get list of servicess
exports.index = function(req, res) {
  if(req.query.homepage){
    Services.find({}).exec(function (err, servicess) {
      if(err) { return handleError(res, err); }
      return res.status(200).json(Muted.List(servicess));
    });
  }
  else{
    Services.find({}).populate('serviceContent').exec(function (err, servicess) {
      if(err) { return handleError(res, err); }
      return res.status(200).json(Muted.List(servicess));
    });
  }

};

// Get a single services
exports.show = function(req, res) {
  Services.findOne({type:req.params.type}, function (err, services) {
    if(err) { return handleError(res, err); }
    if(!services) { return res.status(404).send('Not Found'); }
    return res.json(Muted.fromJS(services));
  });
};

// Creates a new services in the DB.
exports.create = function(req, res) {
  Services.create(req.body, function(err, services) {
    if(err) { return handleError(res, err); }
    return res.status(201).json(Muted.fromJS(services));
  });
};

// Updates an existing services in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Services.findById(req.params.id, function (err, services) {
    if (err) { return handleError(res, err); }
    if(!services) { return res.status(404).send('Not Found'); }
    var updated = _.merge(services, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.status(200).json(Muted.fromJS(services));
    });
  });
};

// Deletes a services from the DB.
exports.destroy = function(req, res) {
  Services.findById(req.params.id, function (err, services) {
    if(err) { return handleError(res, err); }
    if(!services) { return res.status(404).send('Not Found'); }
    services.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.status(204).send('No Content');
    });
  });
};

exports.dispose = function(req, res) {
  Services.remove({_id: {$in:req.body}}, function (err) {
    if(err) { return handleError(res, err); }
    if(!err) {return res.status(200).send({message:'Data Successfully Deleted'}); }
  });
};

function handleError(res, err) {
  return res.status(500).send(err);
}
