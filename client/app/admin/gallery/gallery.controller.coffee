'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'GalleryCtrl', ($scope,Solicitor) ->
  Solicitor.ListOfImages (result)->
    $scope.images =  result
