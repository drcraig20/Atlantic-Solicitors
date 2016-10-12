'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'ContactUsCtrl', ($scope,ContactUs, NgMap) ->
  NgMap.getMap().then (map) ->
    $scope.googleMap = map

  ContactUs.query (result) ->
    _.each result, (rs)->
      rs.time = 800 * _.random(4)
    $scope.addresses = result

  $scope.showInfo = (e, addr) ->
    $scope.info = addr;
    $scope.googleMap.showInfoWindow('info-window')
