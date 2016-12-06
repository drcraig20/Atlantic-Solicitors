'use strict'

angular.module 'atlanticSolicitorsApp'
.service 'FileUpload',($resource) ->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  $resource 'api/upload/:id/',null,
    delete:
      method: 'DELETE'
      url: 'api/upload'

