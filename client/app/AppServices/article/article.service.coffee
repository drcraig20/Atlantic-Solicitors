'use strict'

angular.module 'atlanticSolicitorsApp'
.service 'Article',($resource) ->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  $resource 'api/articles/:id/',null,
    update:
      method: 'PUT'
      params: id: '@id'
      url: 'api/articles/:id'
    dispose:
      method: 'POST'
      url: 'api/articles/dispose'

