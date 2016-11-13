'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var ArticleSchema = new Schema({
  header: String,
  details: String,
  dt_modified: {type:Date, default:Date.now()}
});

module.exports = mongoose.model('Article', ArticleSchema);
