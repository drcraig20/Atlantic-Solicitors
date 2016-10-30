'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'ProfileCtrl', ($scope,$stateParams,Profile) ->
  Profile.get id:$stateParams.id,(result) ->
    $scope.profile = result
  $scope.barColor =(value) ->
    type = ''
    if value < 25
      type = 'danger'
    else if value < 50
      type = 'warning'
    else if value < 75
      type = 'info'
    else
      type = 'success'
    return type
