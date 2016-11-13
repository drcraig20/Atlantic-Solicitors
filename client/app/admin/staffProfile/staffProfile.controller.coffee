'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'StaffProfileCtrl', ($scope, Profile,$uibModal) ->
  $scope.checkModel = []
  $scope.ids = [];
  modal = null

  profiles = ->
    Profile.getProfiles (result)->
      $scope.profiles = result
      console.log result

  profiles()

  $scope.pushAndPop = (id)->
    if id not in $scope.ids
      $scope.ids.push id
    else if id in $scope.ids
      _.remove $scope.ids, (a)->
        a == id
    console.log $scope.ids

  $scope.StaffModal =(content) ->
    $scope.modalContent = {}
    if content? and content isnt undefined then $scope.modalContent = content
    modal = $uibModal.open
      templateUrl: 'app/admin/staffProfile/StaffModal.html'
      backdrop: 'static'
      scope: $scope
      size: 'lg'

  $scope.cancel = ()->
    $scope.submitting = false
    modal.close()

