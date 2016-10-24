'use strict'

angular.module 'atlanticSolicitorsApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ui.router',
  'ui.bootstrap',
  'ngMap',
  'ngFx',
  'ngAnimate'
]
.config ($stateProvider, $urlRouterProvider, $locationProvider) ->
  $urlRouterProvider
  .otherwise '/'

  $locationProvider.html5Mode true
.run ($state,$rootScope) ->
  $rootScope.$on '$stateChangeSuccess', ->
    document.body.scrollTop = document.documentElement.scrollTop = 0
  $rootScope.$state = $state

  $rootScope.goToState = (state) ->
    $state.go state
.factory 'Utils', () ->
# JavaScript equivalent of PHP's nl2br function
# to convert \n to <br>
  nl2br: (str, is_xhtml) ->
    breakTag = if is_xhtml or typeof is_xhtml is 'undefined' then '<br />' else '<br>'
    (str + '').replace /([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, ('$1' + breakTag + '$2')
