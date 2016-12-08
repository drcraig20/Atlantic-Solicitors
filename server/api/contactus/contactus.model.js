'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var ContactusSchema = new Schema({
  name: String,
  location: String,
  address: String,
  email: String,
  geoAddress:String,
  telephone : Array,
  fax: Array,
  workHours: Array,
  description : String,
  emergency : String,
  dt_modified: {type:Date, default:Date.now()}
});

module.exports = mongoose.model('Contactus', ContactusSchema,'contactUs');
