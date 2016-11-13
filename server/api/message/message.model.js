'use strict';

var mongoose = require('mongoose'),
  Schema = mongoose.Schema;

var MessageSchema = new Schema({
  name: String,
  email: {type:String, isLowercase:true},
  content: String,
  dt_created:{type:Date, default:Date.now()},
  read:{type:Boolean, default:false}
});

module.exports = mongoose.model('Message', MessageSchema);

