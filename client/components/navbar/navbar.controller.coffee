'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'NavbarCtrl', ($scope, $location, NavBar, $rootScope) ->
  $scope.isCollapsed = true


  NavBar.query (result) ->
    $scope.navigation = result

  $scope.$State =  $rootScope.$state.current

  $('.dropdown').hover(()->
    $('.dropdown-toggle', this).trigger('click')
    );

