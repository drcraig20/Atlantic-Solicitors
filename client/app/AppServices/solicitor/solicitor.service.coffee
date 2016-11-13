'use strict'

angular.module 'atlanticSolicitorsApp'
.service 'Solicitor', ($resource)->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  $resource 'api/solicitors',null,
    getDetails:
      method:'GET'
      url:'api/solicitors/details'
      isArray:false
    ListOfImages:
      method: 'POST'
      url:'api/solicitors/images'
      isArray:true
    updatePushOrPop:
      method: 'PATCH'
      params: mode: '@mode',type:'@type'
      url: 'api/solicitors/:mode/:type'
