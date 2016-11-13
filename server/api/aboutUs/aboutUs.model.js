'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var AboutUsSchema = new Schema({
  link: String,
  content: String,
  dt_modified: Date
});

module.exports = mongoose.model('AboutUs', AboutUsSchema);
