'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider.state 'editPage',
    url: '/editPage?name&url'
    templateUrl: 'app/admin/editPage/editPage.html'
    controller: 'EditPageCtrl'
    title: 'Pages'
