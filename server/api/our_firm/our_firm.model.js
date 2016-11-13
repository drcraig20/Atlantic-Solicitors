'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var OurFirmSchema = new Schema({
  link: String,
  content: String,
  dt_modified: Date
});

module.exports = mongoose.model('OurFirm', OurFirmSchema, 'ourFirm');
