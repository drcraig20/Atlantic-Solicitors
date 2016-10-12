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
  description : String
});

module.exports = mongoose.model('Contactus', ContactusSchema,'contactUs');
