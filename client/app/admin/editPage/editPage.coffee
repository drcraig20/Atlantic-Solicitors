'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider.state 'editPage',
    url: '/editPage?name&url'
    templateUrl: 'app/editPage/editPage.html'
    controller: 'EditPageCtrl'
