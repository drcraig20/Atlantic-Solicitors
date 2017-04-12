'use strict'

angular.module 'atlanticSolicitorsApp'
.service 'OurServices',($resource) ->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  $resource 'api/services',null,
    update:
      method: 'PUT'
      params: id: '@id'
      url: 'api/services/:id'
    deleteMultiple:
      method: 'POST'
      url: 'api/services/dispose'
