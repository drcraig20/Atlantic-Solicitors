'use strict'

angular.module 'atlanticSolicitorsApp'
.service 'ServiceContent',($resource) ->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  $resource 'api/serviceContents',null,
    update:
      method: 'PUT'
      params: id: '@id'
      url: 'api/serviceContents/:id'
