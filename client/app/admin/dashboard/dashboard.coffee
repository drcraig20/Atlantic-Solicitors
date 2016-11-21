'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider.state 'dashboard',
    url: '/dashboard'
    guestView: false
    templateUrl: 'app/admin/dashboard/dashboard.html'
    controller: 'DashboardCtrl'
    title: 'Dashboard'
