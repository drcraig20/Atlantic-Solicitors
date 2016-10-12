'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'FooterCtrl', ($scope, $location, NavBar) ->

  NavBar.query (result) ->
    $scope.navigation = result

  NavBar.getTestimony (response) ->
    $scope.testimonials = response


