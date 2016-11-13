'use strict'

angular.module 'atlanticSolicitorsApp'
.service 'Message',($resource) ->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  $resource 'api/messages',null,
    stat:
      method: 'GET'
      url: 'api/messages/stat'
    update:
      method: 'PUT'
      params: id: '@id'
      url: 'api/messages/:id'
