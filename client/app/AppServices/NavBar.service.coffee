'use strict'

angular.module 'atlanticSolicitorsApp'
.service 'NavBar' ,($resource) ->
  $resource 'api/navbars',null,
    getTestimony:
      method:'GET'
      url:'api/navbars/testimonials'
      isArray:true


