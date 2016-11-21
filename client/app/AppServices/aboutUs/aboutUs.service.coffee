'use strict'

angular.module 'atlanticSolicitorsApp'
.service 'AboutUs',($resource) ->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  $resource 'api/aboutUs',null,
    update:
      method: 'PUT'
      params: id: '@id'
      url: 'api/aboutUs/:id'
    deleteMultiple:
      method: 'POST'
      url: 'api/aboutUs/dispose'
