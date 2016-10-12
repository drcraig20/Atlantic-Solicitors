'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider.state 'contact_us',
    url: '/contact_us'
    templateUrl: 'app/contact_us/contact_us.html'
    controller: 'ContactUsCtrl'
