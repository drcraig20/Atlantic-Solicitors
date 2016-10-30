'use strict';

var _ = require('lodash'),
  jwt = require('jwt-simple'),
  moment = require('moment'),
  Auth = require('./auth.model'),
  bcrypt   = require('bcrypt-nodejs');

function createJWT(user) {

  var payload = {
    sub: user._id,
    email: user.email,
    username: user.username,
    name: user.name,
    iat: moment().unix(),
    exp: moment().add(3, 'hours').unix()
  };
  return jwt.encode(payload, process.env.SESSION_SECRET);
}

function validPassword(user,password,done) {
  bcrypt.compare(password, user.password, function(err, isMatch) {
    done(err, isMatch);
  });
}


//sign in
exports.signIn = function (req, res) {
  Auth.findOne({
    username: req.body.username.toLowerCase()
  }, '+password', function (err, user) {
    if (!user) {
      return res.status(401).send({message: 'Wrong username and/or password'});
    }

    validPassword(user,req.body.password, function (err, isMatch) {
      if (!isMatch) {
        return res.status(401).send({message: 'Your Password Does Not Match'});
      }
      var token = createJWT(user);

      return res.send({token: token, role: 'admin'});

    });
  });
};



// Get list of auths
exports.index = function(req, res) {
  Auth.find(function (err, auths) {
    if(err) { return handleError(res, err); }
    return res.status(200).json(auths);
  });
};

// Get a single auth
exports.show = function(req, res) {
  Auth.findById(req.params.id||req.user, function (err, auth) {
    if(err) { return handleError(res, err); }
    if(!auth) { return res.status(404).send('Not Found'); }
    return res.json(auth);
  });
};

// Creates a new auth in the DB.
exports.create = function(req, res) {
  Auth.create(req.body, function(err, auth) {
    if(err) { return handleError(res, err); }
    return res.status(201).json(auth);
  });
};

// Updates an existing auth in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Auth.findById(req.params.id, function (err, auth) {
    if (err) { return handleError(res, err); }
    if(!auth) { return res.status(404).send('Not Found'); }
    var updated = _.merge(auth, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.status(200).json(auth);
    });
  });
};

// Deletes a auth from the DB.
exports.destroy = function(req, res) {
  Auth.findById(req.params.id, function (err, auth) {
    if(err) { return handleError(res, err); }
    if(!auth) { return res.status(404).send('Not Found'); }
    auth.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.status(204).send('No Content');
    });
  });
};

function handleError(res, err) {
  return res.status(500).send(err);
}
