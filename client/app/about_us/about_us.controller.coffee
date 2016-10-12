'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'AboutUsCtrl', ($scope, AboutUs, $timeout) ->

  $timeout ->
    AboutUs.query (results)->
      $scope.about = results
  ,100







