'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var ServiceContentSchema = new Schema({
  content: Array,
  type: String,
  dt_modified:Date
});

module.exports = mongoose.model('ServiceContent', ServiceContentSchema, 'serviceContent');
