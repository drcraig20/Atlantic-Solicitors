'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var AboutUsSchema = new Schema({
  link: String,
  details: String,
  active: Boolean,
  dt_modified: Date
});

module.exports = mongoose.model('AboutUs', AboutUsSchema);
