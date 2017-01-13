'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema,
    bcrypt   = require('bcrypt-nodejs');

var AuthSchema = new Schema({
  username : {
    type: String,
    unique: true,
    lowercase: true
  },
  name     : {
    type: String
  },
  email : {
    type: String,
    lowercase: true
  },
  password     : {
    type: String,
    select: false
  },
  role:String,
  lastLogin: Date,
  dt_modified: {
    type: Date,
    default: Date.now
  }
});

AuthSchema.methods.generateHash = function(password) {
  return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
};

module.exports = mongoose.model('Auth', AuthSchema,'auths');
