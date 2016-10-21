'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var ServicesSchema = new Schema({
  name: String,
  text: String,
  type: Boolean,
  imageUrl:String,
  serviceContent : { type: Schema.Types.ObjectId, ref: 'ServiceContent' },
  dt_modified: Date
});

module.exports = mongoose.model('Services', ServicesSchema,'Services');
