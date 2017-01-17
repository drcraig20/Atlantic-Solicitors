/**
 * Created by DrCraig LawPav on 10/1/2016.
 */
'use strict';

var mongoose = require('mongoose'),
  Schema = mongoose.Schema;

var TestimonySchema = new Schema({
  testimony: String,
  author: String,
  approved: {type:Boolean, default:false},
  dt_created:{type:Date,default:Date.now()},
  dt_modified: Date
});

module.exports = mongoose.model('Testimonial', TestimonySchema,'Testimonials');
