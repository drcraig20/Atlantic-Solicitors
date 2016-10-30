'use strict'

angular.module 'atlanticSolicitorsApp'
.service 'Auth', ($resource) ->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  $resource '/auth/:id', null,
    update: method:'PUT'
    me:
      method: 'GET'
      url: '/auth/me'

