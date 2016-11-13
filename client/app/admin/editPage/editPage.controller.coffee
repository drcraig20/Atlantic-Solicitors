'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'EditPageCtrl', ($scope, $stateParams,$injector,$timeout,toastr,$uibModal,ServiceContent) ->
  $scope.obj = $stateParams
  $scope.modalContent = null
  modal = null

  if $stateParams.name is 'Home'
    $scope.serviceName = 'Home'
  else if $stateParams.name is 'About Us'
    $scope.serviceName = 'AboutUs'
  else if $stateParams.name is 'Our Firm'
    $scope.serviceName = 'OurFirm'
  else if $stateParams.name is 'Our Services'
    $scope.serviceName = 'OurServices'
  else if $stateParams.name is 'Contact Us'
    $scope.serviceName = 'ContactUs'

  if $scope.serviceName and $scope.serviceName isnt undefined
    Service = $injector.get $scope.serviceName
    Service.query (result)->
      console.log $scope.Content = result
      $timeout ()->
        angular.element('.panel-heading').hover (->
            angular.element(this).find('.panel-btns').fadeIn 'fast'
          ), ->
          angular.element(this).find('.panel-btns').fadeOut 'fast'
      # Close Panel
          angular.element('.panel .panel-close').click ->
            angular.element(this).closest('.panel').fadeOut 200
            false
          angular.element('.panel .panel-minimize').click ->
            t = angular.element(this)
            p = t.closest('.panel')
            if !angular.element(this).hasClass('maximize')
              p.find('.panel-body, .panel-footer').slideUp 200
              t.addClass 'maximize'
              t.find('i').removeClass('fa-minus').addClass 'fa-plus'
              angular.element(this).attr('data-original-title', 'Maximize Panel').tooltip()
            else
              p.find('.panel-body, .panel-footer').slideDown 200
              t.removeClass 'maximize'
              t.find('i').removeClass('fa-plus').addClass 'fa-minus'
              angular.element(this).attr('data-original-title', 'Minimize Panel').tooltip()
            false
      ,1000

  $scope.editorContact = (content)->
    $scope.contactContent = content
    modal = $uibModal.open
      templateUrl: 'app/admin/editPage/EditorContact.html'
      backdrop: 'static'
      scope: $scope
      size: 'lg'


  $scope.editor = (content,index)->
    $scope.modalContent = content
    if index? and index isnt undefined then $scope.ind = index
    modal = $uibModal.open
      templateUrl: 'app/admin/editPage/EditorModal.html'
      backdrop: 'static'
      scope: $scope
      size: 'lg'

  $scope.cancel = ()->
    $scope.submitting = false
    modal.close()

  $scope.save = ()->
    $scope.submitting = true
    if $scope.contactContent? and $scope.contactContent isnt undefined and $scope.obj.url is 'contact_us'  then $scope.modalContent = $scope.contactContent
    if $scope.obj.url is 'our_services'
      Service = ServiceContent
    else Service = $injector.get $scope.serviceName
    if $scope.modalContent.__v then delete $scope.modalContent.__v
    Service.update id:$scope.modalContent._id,$scope.modalContent, (result) ->
      if result._id
        modal.close()
        $scope.submitting = false
#        $scope.Content[$scope.contactId] = result
        toastr.success 'Data Successfully Saved'
    ,(e) ->
      $scope.submitting = false
      toastr.error 'Opps!!! Something went wrong, and data could not be saved'

