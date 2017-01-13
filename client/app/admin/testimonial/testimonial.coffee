'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider.state 'testimonial',
    url: '/testimonial'
    templateUrl: 'app/admin/testimonial/testimonial.html'
    controller: 'TestimonialCtrl'
