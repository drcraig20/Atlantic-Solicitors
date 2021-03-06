'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'ContactUsCtrl', ($scope,ContactUs, NgMap) ->
  NgMap.getMap().then (map) ->
    $scope.googleMap = map

  ContactUs.query (result) ->
    $scope.addresses = result

  $scope.showInfo = (e, addr,index) ->
    $scope.info = addr;
    $scope.googleMap.showInfoWindow('info-window')
