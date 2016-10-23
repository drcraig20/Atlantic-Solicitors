'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider.state 'profile',
    url: '/profile'
    templateUrl: 'app/profile/profile.html'
    controller: 'ProfileCtrl'
