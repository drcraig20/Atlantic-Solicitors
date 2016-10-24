'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider.state 'profile',
    url: '/profile?id'
    templateUrl: 'app/profile/profile.html'
    controller: 'ProfileCtrl'
