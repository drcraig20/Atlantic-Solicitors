'use strict'

angular.module 'atlanticSolicitorsApp'
.service 'Solicitor', ($resource)->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  $resource 'api/solicitors',null,
    getDetails:
      method:'GET'
      url:'api/solicitors/details'
      isArray:false
