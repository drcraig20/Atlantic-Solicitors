'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'GalleryCtrl', ($scope,Solicitor,Upload,toastr) ->
  Solicitor.ListOfImages (result)->
    $scope.images =  result

  $scope.submit = ->
    if $scope.form.file.$valid and $scope.file
      $scope.upload $scope.file

  $scope.upload = (file) ->
    Upload.upload(
      url: '/api/upload'
      data:
        file: file
    ).then ((resp) ->
      if resp.status is 200 and resp.statusText is 'OK'
        toastr.success 'File Successfully uploaded to Server'
    ), ((resp) ->
      console.log 'Error status: ' + resp.status
    ), (evt) ->
      progressPercentage = parseInt(100.0 * evt.loaded / evt.total)
      console.log 'progress: ' + progressPercentage + '% ' + evt.config.data.file.name
