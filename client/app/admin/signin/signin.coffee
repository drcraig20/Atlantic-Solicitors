'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider.state 'signin',
    url: '/signin'
    guestView: true
    templateUrl: 'app/admin/signin/signin.html'
    controller: 'SigninCtrl'
