'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'GalleryCtrl', ($scope,Solicitor,Upload,toastr,SweetAlert,FileUpload) ->
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
        Solicitor.ListOfImages (result)->
          $scope.images =  result
    ), ((resp) ->
      console.log 'Error status: ' + resp.status
    ), (evt) ->
      progressPercentage = parseInt(100.0 * evt.loaded / evt.total)
      console.log 'progress: ' + progressPercentage + '% ' + evt.config.data.file.name

  $scope.deleteImage = (image)->
    SweetAlert.swal {
      title: 'Are you sure?'
      text: 'This image will be permanently deleted from the server!!!'
      type: 'warning'
      showCancelButton: true
      confirmButtonColor: '#DD6B55'
      confirmButtonText: 'Yes, delete it!'
      closeOnConfirm: false
    },(isConfirm) ->
      if isConfirm
        FileUpload.delete {name: image}, (response)->
          if response.status is 'ok'
            Solicitor.ListOfImages (result)->
              $scope.images =  result
            SweetAlert.swal("Deleted!", image+" was successfully deleted", "success");
            toastr.success response.message
          else toastr.error 'Failed to delete image from server'

