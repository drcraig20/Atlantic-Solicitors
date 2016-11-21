'use strict'

angular.module 'atlanticSolicitorsApp'
.service 'OurFirm',($resource) ->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  $resource 'api/our_firm',null,
    update:
      method: 'PUT'
      params: id: '@id'
      url: 'api/our_firm/:id'
    deleteMultiple:
      method: 'POST'
      url: 'api/our_firm/dispose'
