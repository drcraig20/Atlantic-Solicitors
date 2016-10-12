'use strict'

angular.module 'atlanticSolicitorsApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ui.router',
  'ui.bootstrap',
  'ngMap',
  'ui.utils',
  'ngFx',
  'ngAnimate'
]
.config ($stateProvider, $urlRouterProvider, $locationProvider) ->
  $urlRouterProvider
  .otherwise '/'

  $locationProvider.html5Mode true
.run ($state,$rootScope) ->
  $rootScope.$state = $state
