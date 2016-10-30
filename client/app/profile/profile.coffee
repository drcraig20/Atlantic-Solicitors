'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider.state 'profile',
    guestView: true
    url: '/profile?id'
    templateUrl: 'app/profile/profile.html'
    controller: 'ProfileCtrl'
