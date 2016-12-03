'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var OurFirmSchema = new Schema({
  link: String,
  content: String,
  dt_modified: Date,
  desc: String,
  image: String
});

module.exports = mongoose.model('OurFirm', OurFirmSchema, 'ourFirm');
