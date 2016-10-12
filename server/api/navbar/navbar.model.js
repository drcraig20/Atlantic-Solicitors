'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var NavbarSchema = new Schema({
  class: String,
  name: String,
  url: String,
  dropmenu:Array
});

module.exports = mongoose.model('Navbar', NavbarSchema);
