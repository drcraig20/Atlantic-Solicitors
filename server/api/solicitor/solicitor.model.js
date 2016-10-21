'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var SolicitorSchema = new Schema({
  mode: String,
  images: Array,
  dt_modified: Date,
  Highlight:Array
});

module.exports = mongoose.model('Solicitor', SolicitorSchema,'Solicitors');
