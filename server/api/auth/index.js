'use strict';

var express = require('express');
var sessionSec = require('../../components/tools/sessionSec');
var controller = require('./auth.controller');

var router = express.Router();


router.post('/signin', controller.signIn);
router.get('/', controller.index);
router.get('/me', sessionSec, controller.show);
router.get('/:id',sessionSec, controller.show);
router.post('/', controller.create);
router.put('/:id',sessionSec, controller.update);
router.patch('/:id',sessionSec, controller.update);
router.delete('/:id',sessionSec, controller.destroy);

module.exports = router;
