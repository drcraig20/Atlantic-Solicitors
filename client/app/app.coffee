'use strict'

angular.module 'atlanticSolicitorsApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ui.router',
  'ui.bootstrap',
  'ngMap',
  'toastr',
  'ngFx',
  'ngAnimate',
  'satellizer'
]
.config ($stateProvider, $authProvider,$urlRouterProvider, $locationProvider) ->
  $authProvider.logoutRedirect = '/signin'
  $authProvider.loginOnSignup = false
  $authProvider.signupRedirect = false
  $authProvider.loginUrl = '/auth/signin'
  $authProvider.loginRoute = '/signin'

  $authProvider.tokenPrefix = '__natlanticSolicitors__'

  $authProvider.platform = 'browser'
  $authProvider.storage = 'sessionStorage'


  $urlRouterProvider
  .otherwise '/'

  $locationProvider.html5Mode true
.run ($state,$auth,$rootScope,$window, NavBar) ->

  if $rootScope.navigation? or $rootScope.navigation isnt undefined 
    console.log $rootScope.navigation
  else
    NavBar.query (result) ->
      $rootScope.navigation = result


  $rootScope.ago = (dt) ->
    moment(dt).fromNow()

  $rootScope.$auth = $auth

  $rootScope.$user = $auth.getPayload()

  $rootScope.$on '$stateChangeSuccess', ->
    document.body.scrollTop = document.documentElement.scrollTop = 0
  $rootScope.$state = $state

  $rootScope.$on '$stateChangeStart', (event, next) ->
    if not $auth.isAuthenticated() and not next.guestView then $window.location.href = '/signin'

  $rootScope.goToState = (state) ->
    $state.go state
.factory 'Utils', () ->
# JavaScript equivalent of PHP's nl2br function
# to convert \n to <br>
  nl2br: (str, is_xhtml) ->
    breakTag = if is_xhtml or typeof is_xhtml is 'undefined' then '<br />' else '<br>'
    (str + '').replace /([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, ('$1' + breakTag + '$2')
