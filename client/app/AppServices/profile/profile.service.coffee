'use strict'

angular.module 'atlanticSolicitorsApp'
.service 'Profile',($resource) ->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  $resource 'api/profiles/:id/',null,
    getProfiles:
      method: 'GET'
      isArray: true
      url: '/api/profiles'
    update:
      method: 'PUT'
      params: id: '@id'
      url: 'api/profiles/:id'
    deleteMultiple:
      method: 'POST'
      url: 'api/profiles/dispose'
