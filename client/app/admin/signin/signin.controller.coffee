'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'SigninCtrl', ($scope,$rootScope,Auth,$timeout,$auth,toastr,$window) ->
  if $auth.isAuthenticated()
    $window.location.href = '/dashboard'

  $scope.login = ->
    $scope.formError = null
    $scope.submitting = true

    $auth.login
      username: $scope.username
      password: $scope.password
    .then (r) ->
      Auth.me (user) ->
        console.log(r)
        $rootScope.$user = user

        toastr.success 'Login Successful!'
        $timeout ()->
          $window.location.href = '/dashboard'
        ,500

    , (e) ->
      $scope.submitting = false
      toastr.error e.data.message
      $scope.formError = e.data.message

