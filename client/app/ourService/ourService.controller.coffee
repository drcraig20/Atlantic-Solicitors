'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'OurServiceCtrl', ($scope,OurServices,Utils,$stateParams) ->
  $scope.services = []
  if $stateParams.name
    $scope.CategoryView = false
  else $scope.CategoryView = true
  OurServices.query (result)->
    if result.length
      $scope.services = result
    $scope.intro = _.find $scope.services, 'type'

  $scope.ReadMore = (id)->
    $scope.service = _.find($scope.services, {_id:id})
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

  if $stateParams.name
    $scope.$watchCollection 'services', (newValue, oldValue) ->
      if newValue.length and newValue isnt []
        $scope.ReadMore($stateParams.name)


