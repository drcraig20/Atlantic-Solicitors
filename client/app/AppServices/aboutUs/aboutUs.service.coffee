'use strict'

angular.module 'atlanticSolicitorsApp'
.service 'AboutUs',($resource) ->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  $resource 'api/aboutUs',null
