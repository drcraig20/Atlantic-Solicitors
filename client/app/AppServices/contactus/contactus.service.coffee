'use strict'

angular.module 'atlanticSolicitorsApp'
.service 'ContactUs',($resource) ->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  $resource 'api/contactUs',null
