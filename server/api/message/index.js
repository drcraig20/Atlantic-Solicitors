'use strict';

var express = require('express');
var controller = require('./message.controller');

var router = express.Router();

router.get('/', controller.index);
router.get('/stat', controller.stats);
router.post('/send', controller.send);
router.get('/:id', controller.show);
router.post('/', controller.create);
router.post('/dispose', controller.dispose);
router.put('/:id', controller.update);
router.patch('/:id', controller.update);
router.delete('/:id', controller.destroy);

module.exports = router;
