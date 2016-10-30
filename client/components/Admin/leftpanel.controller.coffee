'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'LeftPanelCtrl', ($scope, NavBar, $rootScope,$state) ->
  $scope.messageCollapsed = false
  $scope.isUICollapsed = true
  $scope.isFormCollapsed = true
  $scope.isTableCollapsed = true
  $scope.isPagesCollapsed = true
  $scope.isNavCollapsed = true

  $scope.status = {
    isOpen: false
  };


  if $rootScope.navigation? and $rootScope.navigation isnt undefined
    $scope.pagesLink = $rootScope.navigation
  else
    NavBar.query (result) ->
      $scope.pagesLink = $rootScope.navigation = result

  $scope.$State =  $rootScope.$state.current


