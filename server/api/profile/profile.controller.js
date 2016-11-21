'use strict';

var _ = require('lodash');
var Profile = require('./profile.model');
var Muted = require('immutable');

// Get list of profiles
exports.index = function(req, res) {
  if (req.query.id){
    Profile.find({}, 'fullname about_me',function (err, profiles) {
      if(err) { return handleError(res, err); }
      return res.status(200).json(Muted.List(profiles));
    });
  }
  else {
    Profile.find(function (err, profiles) {
      if(err) { return handleError(res, err); }
      return res.status(200).json(Muted.List(profiles));
    });
  }

};

// Get a single profile
exports.show = function(req, res) {
  console.log(req.params);
  Profile.findById(req.params.id, function (err, profile) {
    if(err) { return handleError(res, err); }
    if(!profile) { return res.status(404).send('Not Found'); }
    return res.json(profile);
  });
};

// Creates a new profile in the DB.
exports.create = function(req, res) {
  Profile.create(req.body, function(err, profile) {
    if(err) { return handleError(res, err); }
    return res.status(201).json(profile);
  });
};

// Updates an existing profile in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Profile.findById(req.params.id).select('about_me fullname dt_modified').exec( function (err, profile) {
    if (err) { return handleError(res, err); }
    if(!profile) { return res.status(404).send('Not Found'); }
    var updated = _.merge(profile, req.body);
    updated.dt_modified = Date.now();
    updated.markModified('contact');
    updated.markModified('experiences');
    updated.markModified('hobbies');
    updated.markModified('languages');
    updated.markModified('qualification');
    updated.markModified('skills');
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.status(200).json(profile);
    });
  });
};

// Deletes a profile from the DB.
exports.destroy = function(req, res) {
    Profile.findById(req.params.id, function (err, profile) {
      if(err) { return handleError(res, err); }
      if(!profile) { return res.status(404).send('Not Found'); }
      profile.remove(function(err) {
        if(err) { return handleError(res, err); }
        return res.status(204).send('No Content');
      });
    });
};


// Deletes a profile from the DB.
exports.dispose = function(req, res) {
  Profile.remove({_id: {$in:req.body}}, function (err) {
    if(err) { return handleError(res, err); }
    if(!err) {return res.status(200).send({message:'Data Successfully Deleted'}); }
  });
};

function handleError(res, err) {
  return res.status(500).send(err);
}
