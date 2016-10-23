'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'OurServiceCtrl', ($scope,OurServices,Utils) ->
  $scope.CategoryView = true
  OurServices.query (result)->
    if result.length
      $scope.services = result
    $scope.intro = _.find $scope.services, 'type'

  $scope.ReadMore = (id)->
    $scope.service = $scope.services[id]
    $scope.CategoryView = false
    $scope.inLine = {}
    $scope.inLine.header = $scope.service.serviceContent.content[0].header
    $scope.inLine.details = Utils.nl2br($scope.service.serviceContent.content[0].details)
    $scope.inLine.id = 0

  $scope.setText = (id)->
    $scope.inLine.header = $scope.service.serviceContent.content[id].header
    $scope.inLine.details = Utils.nl2br($scope.service.serviceContent.content[id].details)
    $scope.inLine.id = id

  $scope.back = ()->
    $scope.CategoryView = true




