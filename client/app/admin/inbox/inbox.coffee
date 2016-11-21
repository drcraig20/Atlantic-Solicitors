'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider.state 'inbox',
    url: '/admin/inbox'
    templateUrl: 'app/admin/inbox/inbox.html'
    controller: 'InboxCtrl'
    title: 'Inbox'
