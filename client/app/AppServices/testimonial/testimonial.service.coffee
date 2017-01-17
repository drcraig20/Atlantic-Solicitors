'use strict'

angular.module 'atlanticSolicitorsApp'
.service 'Testimonial',($resource) ->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  $resource 'api/testimonials',null,
    dispose:
      method: 'POST'
      url: 'api/testimonials/dispose'
    update:
      method: 'PUT'
      params: id: '@id'
      url: 'api/testimonials/:id'
