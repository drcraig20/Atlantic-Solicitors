'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'NavbarCtrl', ($scope, $location, NavBar, $rootScope) ->
  $scope.isCollapsed = true
  if $rootScope.navigation?
  else
    NavBar.query (result) ->
      $rootScope.navigation = result

  $scope.$State =  $rootScope.$state.current


