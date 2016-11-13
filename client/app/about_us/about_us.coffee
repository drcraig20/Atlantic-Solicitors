'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider.state 'about_us',
    url: '/about_us'
    guestView: true
    templateUrl: 'app/about_us/about_us.html'
    controller: 'AboutUsCtrl'
