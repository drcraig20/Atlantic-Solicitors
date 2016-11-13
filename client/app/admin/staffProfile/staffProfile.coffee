'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider.state 'staffProfile',
    url: '/staffProfile'
    templateUrl: 'app/admin/staffProfile/staffProfile.html'
    controller: 'StaffProfileCtrl'
