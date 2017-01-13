'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'LeftPanelCtrl', ($scope, NavBar, $rootScope,Message,$auth,$state) ->
  $scope.messageCollapsed = false
  $scope.isUICollapsed = true
  $scope.isFormCollapsed = true
  $scope.isTableCollapsed = true
  $scope.isPagesCollapsed = true
  $scope.isNavCollapsed = true

  $scope.status = {
    isOpen: false
  };

  $scope.signOut = ()->
    $auth.logout()
    $state.go 'signin'


  if $rootScope.navigation? and $rootScope.navigation isnt undefined
    $scope.pagesLink = $rootScope.navigation
  else
    NavBar.query (result) ->
      $scope.pagesLink = $rootScope.navigation = result

  Message.stat (count) ->
    $rootScope.count = count

  Message.query limit: 5, (response)->
    $scope.headerMessage = response

  $scope.$State =  $rootScope.$state.current


