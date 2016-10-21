'use strict'

angular.module 'atlanticSolicitorsApp'
.service 'OurServices',($resource) ->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  $resource 'api/services',null
