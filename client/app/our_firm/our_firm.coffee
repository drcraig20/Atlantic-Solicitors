'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider.state 'our_firm',
    url: '/our_firm'
    templateUrl: 'app/our_firm/our_firm.html'
    controller: 'OurFirmCtrl'
