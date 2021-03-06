'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'StaffProfileCtrl', ($scope, Profile,$uibModal,toastr,cloudinary,Upload,FileUpload) ->
  $scope.checkModel = []
  $scope.submitting = false
  $scope.ids = [];
  modal = null
  contentModal = null
  $scope.dropdownvalue = 'Select Contact Type'
  $scope.content = {}

  profiles = ->
    Profile.getProfiles (result)->
      $scope.profiles = result
  profiles()

  $scope.pushAndPop = (id)->
    if id not in $scope.ids
      $scope.ids.push id
    else if id in $scope.ids
      _.remove $scope.ids, (a)->
        a == id

  $scope.StaffModal =(content) ->
    $scope.modalContent = {}
    if content? and content isnt undefined
      $scope.modalContent = content
      $scope.newProfile = false
    else $scope.newProfile = true
    modal = $uibModal.open
      templateUrl: 'app/admin/staffProfile/StaffModal.html'
      backdrop: 'static'
      scope: $scope
      size: 'lg'


  $scope.deleteCancel = ()->
    if $scope.file
      if $scope.modalContent.image then delete $scope.modalContent.image
      $scope.modalContent.image = $scope.oldImage
#      FileUpload.delete {name: $scope.file.name}, (response)->
#        if response.status is 'ok' then console.log response.message

  $scope.cancel = (int)->
    $scope.submitting = false
    if int? and int isnt undefined and int is 2
      contentModal.close()
    else
      $scope.submitting = false
      modal.close()
      console.log $scope.file
      if $scope.file
        $scope.deleteCancel()

  $scope.saveEditedProfile = ()->
    $scope.submitting = true
    if $scope.modalContent.__v then delete $scope.modalContent.__v
    if $scope.newProfile
      Profile.save $scope.modalContent, (result) ->
        if result._id
          modal.close()
          $scope.submitting = false
          toastr.success 'New Profile Was Successfully Created'
          profiles()
      ,(e) ->
        $scope.submitting = false
        toastr.error 'Opps!!! Something went wrong, and new profile could not be created'
    else
      Profile.update id:$scope.modalContent._id,$scope.modalContent, (result) ->
        if result._id
          modal.close()
          $scope.submitting = false
          toastr.success 'Data Successfully Saved'
      ,(e) ->
          $scope.submitting = false
          toastr.error 'Opps!!! Something went wrong, and data could not be saved'

  $scope.newNestedContent = (type)->
    $scope.nestedContent =
      header:type
    $scope.content = {}
    contentModal = $uibModal.open
      templateUrl: 'app/admin/staffProfile/nestedContentModal.html'
      backdrop: 'static'
      scope: $scope
      size: 'md'

  $scope.saveNested = ()->
    $scope.submitting = true
    switch $scope.nestedContent.header
      when 'Contact'
        if $scope.modalContent.contact is undefined then $scope.modalContent.contact = []
        $scope.modalContent.contact.push({content:$scope.content.contacttext,type:$scope.content.type})
#      when 'Experience'
#        if $scope.modalContent.experiences is undefined then $scope.modalContent.experiences = []
#        $scope.modalContent.experiences.push($scope.content)
#      when 'Qualification'
#        if $scope.modalContent.qualification is undefined then $scope.modalContent.qualification = []
#        $scope.modalContent.qualification.push($scope.content)
#      when 'Skill'
#        if $scope.modalContent.skills is undefined then $scope.modalContent.skills = []
#        $scope.modalContent.skills.push($scope.content)
#      when 'Hobby'
#        if $scope.modalContent.hobbies is undefined then $scope.modalContent.hobbies = []
#        $scope.modalContent.hobbies.push($scope.content.hobby)
#      when 'Language'
#        if $scope.modalContent.languages is undefined then $scope.modalContent.languages = []
#        $scope.modalContent.languages.push($scope.content.language)
    toastr.info 'Data Added but not saved, Please click save on the Opened profile to Save properly'
    contentModal.close()
    $scope.submitting = false

  $scope.deleteNested =(index,type)->
    switch type
      when 'Contact'
        pop $scope.modalContent.contact,index
#      when 'Experience'
#        pop $scope.modalContent.experiences,index
#      when 'Qualification'
#        pop $scope.modalContent.qualification,index
#      when 'Skill'
#        pop $scope.modalContent.skills,index
#      when 'Hobby'
#        pop $scope.modalContent.hobbies,index
#      when 'Language'
#        pop $scope.modalContent.languages,index
    toastr.info 'Data Removed but not saved, Please click save on the Opened profile to Save properly'

# removes an object from an array
  pop = (array,index)->
    obj = array[index]
    _.remove array, (a)->
      a == obj

#      delete selected profiles
  $scope.delete = ->
    if $scope.ids.length
      Profile.deleteMultiple $scope.ids, (response)->
        if response
          toastr.success response.message
          profiles()
      ,(e) ->
        toastr.error 'Data Could Not be deleted.'


  $scope.upload = (file) ->
    $scope.file = file
    Upload.upload
      url: "https://api.cloudinary.com/v1_1/" + cloudinary.config().cloud_name + "/upload"
      data:
        skipAuthorization: true
        upload_preset: cloudinary.config().upload_preset
        tags: 'staffPics'
        context: 'photo=' + $scope.modalContent.fullname.replace(" ","")
        file: file
    .progress (evt) ->
      progressPercentage = Math.round((100.0 * evt.loaded) / evt.total)
    .success (data) ->
      $scope.oldImage = $scope.modalContent.image
      $scope.modalContent.image = data.secure_url
      $scope.modalContent.image_url = data.url
      $scope.modalContent.public_id = data.public_id
      toastr.info 'Image uploaded successfully to server Please click save to attach to this profile'
    .error (data) ->
      toastr.error 'Image could not be uploaded please try again'


#  $scope.upload = (file) ->
#    $scope.file = file
#    Upload.upload(
#      url: '/api/upload'
#      data:
#        file: file
#    ).then ((resp) ->
#      if resp.status is 200 and resp.statusText is 'OK'
#        $scope.oldImage = $scope.modalContent.image
#        $scope.modalContent.image = 'assets/images/'+ file.name.toLowerCase()
#        toastr.info 'Image uploaded successfully to server Please click save to attach to this profile'
#    ), ((resp) ->
#      toastr.error 'Error status image could not be saved'
#    ), (evt) ->
#      progressPercentage = parseInt(100.0 * evt.loaded / evt.total)
#      console.log 'progress: ' + progressPercentage + '% ' + evt.config.data.file.name
