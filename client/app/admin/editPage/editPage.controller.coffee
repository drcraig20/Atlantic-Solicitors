'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'EditPageCtrl', ($scope, $stateParams,$injector,$timeout,toastr,$uibModal,ServiceContent) ->
  $scope.obj = $stateParams
  $scope.modalContent = null
  modal = null
  contentModal = null


  $scope.checkModel = {}
  $scope.ids = []

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
      $scope.Content = result
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
    $scope.newContact = false
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
    console.log $scope.contactContent
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
        Service.query (result)->
          $scope.Content = result
        toastr.success 'Data Successfully Saved'
    ,(e) ->
      $scope.submitting = false
      toastr.error 'Opps!!! Something went wrong, and data could not be saved'


#  perform insert and remove operation for delete checkbox
  $scope.pushAndPop = (id)->
    if id not in $scope.ids
      $scope.ids.push id
    else if id in $scope.ids
      _.remove $scope.ids, (a)->
        a == id

# close opened modal
  $scope.cancel = (int)->
    if int? and int isnt undefined
      contentModal.close()
    else
      $scope.submitting = false
      modal.close()

#modal to add new page content
  $scope.editorAdd = ()->
    $scope.newContact = true
    $scope.modalContent = {}
    if $scope.obj.name is 'Contact Us' then template = 'app/admin/editPage/EditorContact.html' ;$scope.contactContent = {} else template = 'app/admin/editPage/PageContent.html'
    modal = $uibModal.open
      templateUrl: template
      backdrop: 'static'
      scope: $scope
      size: 'lg'

#      save new page content
  $scope.saveNew = ()->
    $scope.submitting = true
    if $scope.contactContent? and $scope.contactContent isnt undefined and $scope.obj.url is 'contact_us'  then $scope.modalContent = $scope.contactContent
    if $scope.obj.url is 'our_services'
      Service = ServiceContent
    else Service = $injector.get $scope.serviceName
    Service.save $scope.modalContent, (result) ->
      if result._id
          modal.close()
          Service.query (result)->
            $scope.Content = result
          $scope.submitting = false
          toastr.success 'Data Successfully Saved'
    ,(e) ->
      $scope.submitting = false
      toastr.error 'Opps!!! Something went wrong, and data could not be saved'

#      Open Modal for nested Content
  $scope.newNestedContent = (type)->
    $scope.nestedContent =
      header:type
    $scope.content = {}
    contentModal = $uibModal.open
      templateUrl: 'app/admin/editPage/nestedContactContent.html'
      backdrop: 'static'
      scope: $scope
      size: 'md'


  $scope.saveNested = ()->
    $scope.submitting = true
    switch $scope.nestedContent.header
      when 'telephone'
        if $scope.contactContent.telephone is undefined then $scope.contactContent.telephone = []
        $scope.contactContent.telephone.push($scope.content.telephone)
      when 'fax'
        if $scope.contactContent.fax is undefined then $scope.contactContent.fax = []
        $scope.contactContent.fax.push($scope.content.fax)
      when 'Business Hour'
        if $scope.contactContent.workHours is undefined then $scope.contactContent.workHours = []
        $scope.contactContent.workHours.push($scope.content)
    toastr.info 'Data Added but not saved, Please click save on the Opened Content to Save properly'
    contentModal.close()
    $scope.submitting = false


#    delete a one page content
  $scope.delete = ->
    if $scope.ids.length
      Service.deleteMultiple $scope.ids, (response)->
        if response
          toastr.success response.message
          _.remove($scope.Content,(c)->
            c._id in $scope.ids
          )
      ,(e) ->
        toastr.error 'Data Could Not be deleted.'

#  delete nested object for pages content with nested content
  $scope.deleteNested =(index,type)->
    switch type
      when 'telephone'
        pop $scope.contactContent.telephone,index
      when 'fax'
        pop $scope.contactContent.fax,index
      when 'workHours'
        pop $scope.contactContent.workHours,index
    toastr.info 'Data Removed but not saved, Please click save on the Opened Content to Save properly'

  # removes an object from an array
  pop = (array,index)->
    obj = array[index]
    _.remove array, (a)->
      a == obj

# edit and selecr content of a service
  $scope.openServiceContent =(name)->
    contentModal = $uibModal.open
      templateUrl: 'app/admin/editPage/ServiceContent.html'
      backdrop: 'static'
      controller: 'NestedServiceCtrl'
      size: 'md'
      resolve:
        SContent: -> $scope.Content[name]


.controller 'NestedServiceCtrl', ($scope, $stateParams,ServiceContent,$timeout,toastr,$uibModalInstance,SContent) ->
  $scope.ServiceContent = SContent
  $scope.ids = []
  $scope.checkModel = {}
  #  perform insert and remove operation for delete checkbox
  $scope.pushAndPop = (id)->
    if id not in $scope.ids
      $scope.ids.push id
    else if id in $scope.ids
      _.remove $scope.ids, (a)->
        a == id

  $scope.delete =()->
    _.forEach($scope.ids,(id)->
      obj = $scope.ServiceContent.serviceContent.content[id]
      _.remove $scope.ServiceContent.serviceContent.content, (a)->
        a == obj
    )
    console.log $scope.ServiceContent
    ServiceContent.update {id:$scope.ServiceContent.serviceContent._id}, $scope.ServiceContent.serviceContent,(response)->
      if response
        toastr.success 'Data Successfully Deleted'
        $scope.cancel()
    ,(e)->
      toastr.error 'Something went wrong, data could not be deleted'

  $scope.cancel = ()->
    $scope.submitting = false
    $uibModalInstance.dismiss('cancel')
