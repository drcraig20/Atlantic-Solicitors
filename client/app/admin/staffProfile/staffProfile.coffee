'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider.state 'staffProfile',
    url: '/admin/staffProfile'
    templateUrl: 'app/admin/staffProfile/staffProfile.html'
    controller: 'StaffProfileCtrl'
    title: 'Staff Profiles'
