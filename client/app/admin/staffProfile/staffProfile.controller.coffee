'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'StaffProfileCtrl', ($scope, Profile,$uibModal,toastr) ->
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
      console.log result

  profiles()

  $scope.pushAndPop = (id)->
    if id not in $scope.ids
      $scope.ids.push id
    else if id in $scope.ids
      _.remove $scope.ids, (a)->
        a == id

  $scope.StaffModal =(content) ->
    $scope.modalContent = {}
    if content? and content isnt undefined then $scope.modalContent = content
    modal = $uibModal.open
      templateUrl: 'app/admin/staffProfile/StaffModal.html'
      backdrop: 'static'
      scope: $scope
      size: 'lg'

  $scope.cancel = (int)->
    $scope.submitting = false
    if int? and int isnt undefined and int is 2
      contentModal.close()
    else
      $scope.submitting = false
      modal.close()

  $scope.saveEditedProfile = ()->
    $scope.submitting = true
    if $scope.modalContent.__v then delete $scope.modalContent.__v
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
        $scope.modalContent.contact.push({content:$scope.content.contacttext,type:$scope.content.type})
      when 'Experience'
        $scope.modalContent.experiences.push($scope.content)
      when 'Qualification'
        $scope.modalContent.qualification.push($scope.content)
      when 'Skill'
        $scope.modalContent.skills.push($scope.content)
      when 'Hobby'
        $scope.modalContent.hobbies.push($scope.content.hobby)
      when 'Language'
        $scope.modalContent.languages.push($scope.content.language)
    toastr.info 'Data Added but not saved, Please click save on the Opened profile to Save properly'
    contentModal.close()
    $scope.submitting = false

  $scope.deleteNested =(index,type)->
    switch type
      when 'Contact'
        pop $scope.modalContent.contact,index
      when 'Experience'
        pop $scope.modalContent.experiences,index
      when 'Qualification'
        pop $scope.modalContent.qualification,index
      when 'Skill'
        pop $scope.modalContent.skills,index
      when 'Hobby'
        pop $scope.modalContent.hobbies,index
      when 'Language'
        pop $scope.modalContent.languages,index
    toastr.info 'Data Removed but not saved, Please click save on the Opened profile to Save properly'
    console.log $scope.modalContent

# removes an object from an array
  pop = (array,index)->
    obj = array[index]
    _.remove array, (a)->
      a == obj


