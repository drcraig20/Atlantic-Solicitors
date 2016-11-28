'use strict';

var express = require('express');
var controller = require('./fileUpload');

var router = express.Router();

router.post('/', controller.uploads);

module.exports = router;
