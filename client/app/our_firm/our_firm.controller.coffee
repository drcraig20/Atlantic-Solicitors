'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'OurFirmCtrl', ($scope,OurFirm,$timeout) ->
  $timeout ->
    OurFirm.query (result) ->
       $scope.content = result
  ,200
