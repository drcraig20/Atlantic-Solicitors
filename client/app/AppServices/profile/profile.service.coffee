'use strict'

angular.module 'atlanticSolicitorsApp'
.service 'Profile',($resource) ->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  $resource 'api/profiles/:id/',null,
    getProfiles:
      method: 'GET'
      isArray: true
      url: '/api/profiles'
