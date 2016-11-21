'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var ProfileSchema = new Schema({
  fullname: String,
  about_me: String,
  qualification: Array,
  experiences: Array,
  contact: Array,
  skills: Array,
  languages: Array,
  hobbies: Array,
  dt_modified: {type:Date, default: Date.now()}
});

module.exports = mongoose.model('Profile', ProfileSchema,'Profiles');
