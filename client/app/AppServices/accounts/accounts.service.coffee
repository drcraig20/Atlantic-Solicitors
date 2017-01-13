'use strict'

angular.module 'atlanticSolicitorsApp'
.service 'Accounts',($resource) ->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  $resource 'auth/:id/',null,
    dispose:
      method: 'POST'
      url: 'auth/dispose'
