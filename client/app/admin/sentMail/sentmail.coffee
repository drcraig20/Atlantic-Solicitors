'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider.state 'sent',
    url: '/admin/sentitems'
    templateUrl: 'app/admin/sentMail/sentmail.html'
    controller: 'SentMailCtrl'
    title: 'SentMail'
