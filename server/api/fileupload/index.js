'use strict';

var express = require('express');
var controller = require('./fileUpload');

var router = express.Router();

// router.get('/upload', controller.get);
router.post('/', controller.upload);
router.delete('/', controller.delete);
// router.delete('/assets/images/:name', controller.delete);

module.exports = router;
