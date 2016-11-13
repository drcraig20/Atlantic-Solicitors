'use strict';

var express = require('express');
var controller = require('./solicitor.controller');

var router = express.Router();

router.get('/', controller.index);
router.get('/details', controller.getDetails);
router.get('/:id', controller.show);
router.post('/', controller.create);
router.post('/images', controller.getImages);
router.put('/:id', controller.update);
router.patch('/:mode/:type', controller.updatePush);
router.delete('/:id', controller.destroy);

module.exports = router;
