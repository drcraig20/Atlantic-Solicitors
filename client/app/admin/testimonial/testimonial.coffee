'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider.state 'testimonial',
    url: '/admin/testimonial'
    templateUrl: 'app/admin/testimonial/testimonial.html'
    controller: 'TestimonialCtrl'
