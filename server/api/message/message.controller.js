'use strict';

var _ = require('lodash');
var Message = require('./message.model');

// Get list of messages
exports.index = function(req, res) {
  if (req.query.limit)
  {
    Message.find().limit(parseInt(req.query.limit)).exec(function (err, messages) {
      if(err) { return handleError(res, err); }
      return res.status(200).json(messages);
    });
  }
  else {
    Message.find(function (err, messages) {
      if(err) { return handleError(res, err); }
      return res.status(200).json(messages);
    });
  }

};

// Get a single message
exports.show = function(req, res) {
  Message.findById(req.params.id, function (err, message) {
    if(err) { return handleError(res, err); }
    if(!message) { return res.status(404).send('Not Found'); }
    return res.json(message);
  });
};

// Creates a new message in the DB.
exports.create = function(req, res) {
  console.log(req.body);
  Message.create(req.body, function(err, message) {
    if(err) { return handleError(res, err); }
    return res.status(201).json(message);
  });
};

// Updates an existing message in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Message.findById(req.params.id, function (err, message) {
    if (err) { return handleError(res, err); }
    if(!message) { return res.status(404).send('Not Found'); }
    var updated = _.merge(message, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.status(200).json(message);
    });
  });
};

// Deletes a message from the DB.
exports.destroy = function(req, res) {
  Message.findById(req.params.id, function (err, message) {
    if(err) { return handleError(res, err); }
    if(!message) { return res.status(404).send('Not Found'); }
    message.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.status(204).send('No Content');
    });
  });
};


exports.stats = function (req,res) {
  var stat = {};
  Message.count({read:false}).exec(function (err,count) {
    if(err) { return handleError(res, err); }
    stat.unread = count;
    return res.status(200).send(stat);
  })
};

function handleError(res, err) {
  return res.status(500).send(err);
}
