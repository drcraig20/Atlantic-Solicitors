'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider.state 'our_services',
    url: '/our_services'
    guestView: true
    templateUrl: 'app/ourService/ourService.html'
    controller: 'OurServiceCtrl'
