'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider.state 'accounts',
    url: '/admin/accounts'
    templateUrl: 'app/admin/accounts/accounts.html'
    controller: 'AccountsCtrl'
