'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'MainCtrl', ($scope) ->

  $('.responsive-slider-parallax').responsiveSlider({
    autoplay: true,
    interval: 5000,
    transitionTime: 300,
    parallax: true
  })
