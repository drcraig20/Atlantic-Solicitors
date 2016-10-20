'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'AboutUsCtrl', ($scope, AboutUs) ->
  AboutUs.query (results)->
    $scope.about = results







