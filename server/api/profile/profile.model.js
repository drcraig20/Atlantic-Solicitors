'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var ProfileSchema = new Schema({
  fullname: String,
  about_me: String,
  // qualification: Array,
  // experiences: Array,
  contact: Array,
  // skills: Array,
  // languages: Array,
  // hobbies: Array,
  rank: Number,
  position: String,
  public_id: String,
  image_url: String,
  image: String,
  suffix: String,
  dt_modified: {type:Date, default: Date.now()}
});

module.exports = mongoose.model('Profile', ProfileSchema,'Profiles');
