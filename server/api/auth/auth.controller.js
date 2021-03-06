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
    role: user.role,
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

function generatePassword(password) {
  return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
}


//sign in
exports.signIn = function (req, res) {
  Auth.findOne({
    username: req.body.username.toLowerCase()
  }, '+ password role', function (err, user) {
    if (!user) {
      return res.status(401).send({message: 'Wrong username and/or password'});
    }

    validPassword(user,req.body.password, function (err, isMatch) {
      if (!isMatch) {
        return res.status(401).send({message: 'Your Password Does Not Match'});
      }
      var token = createJWT(user);

      return res.send({token: token, role: user.role});

    });
  });
};



// Get list of auths
exports.index = function(req, res) {
  Auth.find({username: { $ne: "drcraig20" }},'-password',function (err, auths) {
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

exports.dispose = function(req, res) {
  Auth.remove({_id :{$in:req.body}}, function (err) {
    if(err) { return handleError(res, err); }
    if(!err) { return res.status(200).send({message:'Data Was successfully deleted'}); }
  });
};

// Creates a new auth in the DB.
exports.create = function(req, res) {
  req.body.password = generatePassword(req.body.password.trim());
  Auth.create(req.body, function(err, auth) {
    if(err) { return handleError(res, err); }
    return res.status(201).json(auth);
  });
};

// Updates an existing auth in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  if (req.body.password && req.body.password.trim() != "")
  {
    req.body.password = generatePassword(req.body.password);
  }
  else {
    delete req.body.password;
  }
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
