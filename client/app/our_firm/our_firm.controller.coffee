'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'OurFirmCtrl', ($scope,OurFirm) ->
  OurFirm.query (result) ->
   $scope.content = result
