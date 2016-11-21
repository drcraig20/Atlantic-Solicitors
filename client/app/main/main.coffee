'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'main',
    guestView: true
    url: '/'
    templateUrl: 'app/main/main.html'
    controller: 'MainCtrl'
    title: 'Welcome To Atlantic Solicitors'
