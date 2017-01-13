'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'AccountsCtrl', ($scope,$timeout,$rootScope,Auth,$uibModal,toastr,Accounts,SweetAlert) ->
  $scope.submitting = false
  $scope.modalContent = {}
  $scope.checkModel = {};
  $scope.ids = [];
  $scope.dropdownvalue = 'Select Role for Account'
  modal = null
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
        else
          p.find('.panel-body, .panel-footer').slideDown 200
          t.removeClass 'maximize'
          t.find('i').removeClass('fa-plus').addClass 'fa-minus'
        false
  ,1000

  $scope.getUsers = ->
    Auth.query (result)->
      $scope.allUsers = result
  $scope.getUsers()


  $scope.cancel = ()->
    $scope.submitting = false
    modal.close()

  $scope.pushAndPop = (id)->
    if id not in $scope.ids
      $scope.ids.push id
    else if id in $scope.ids
      _.remove $scope.ids, (a)->
        a == id

  $scope.userAdd = ()->
    $scope.newUser = true
    $scope.modalContent = {}
    modal = $uibModal.open
      templateUrl: 'app/admin/accounts/AccountModal.html'
      backdrop: 'static'
      scope: $scope
      size: 'md'

  $scope.userEdit = (user)->
    $scope.newUser = false
    $scope.modalContent = user
    modal = $uibModal.open
      templateUrl: 'app/admin/accounts/AccountModal.html'
      backdrop: 'static'
      scope: $scope
      size: 'md'


  $scope.save = ()->
    $scope.submitting = true
    if $scope.modalContent.__v then delete $scope.modalContent.__v
    Auth.update id:$scope.modalContent._id,$scope.modalContent, (result) ->
      if result._id
        modal.close()
        $scope.submitting = false
        SweetAlert.swal {
          title: 'Success'
          text: 'User Successfully Saved'
          type: 'success'
        }
    ,(e) ->
      $scope.submitting = false
      SweetAlert.swal {
        title: 'Error'
        text: 'User Could not be saved'
        type: 'error'
      }

  $scope.saveNew = ()->
    $scope.submitting = true
    if $scope.modalContent.__v then delete $scope.modalContent.__v
    Auth.save $scope.modalContent, (result) ->
      if result._id
        modal.close()
        $scope.submitting = false
        SweetAlert.swal {
          title: 'Success'
          text: 'User Successfully Created'
          type: 'success'
        }
        $scope.getUsers()
    ,(e) ->
      $scope.submitting = false
      SweetAlert.swal {
        title: 'Error'
        text: 'User Could not be saved'
        type: 'error'
      }


  $scope.delete = ->
      if $scope.ids.length
        SweetAlert.swal {
          title: 'Are you sure?'
          text: if $scope.ids.length > 1 then 'These Users will be permanently deleted' else 'This user will be permanently deleted'
          type: 'warning'
          showCancelButton: true
          confirmButtonColor: '#DD6B55'
          confirmButtonText: 'Yes, delete it!'
          closeOnConfirm: false
        },(isConfirm) ->
          if isConfirm
            Accounts.dispose $scope.ids, (response)->
                  SweetAlert.swal("Deleted!", response.message, "success");
                  toastr.success response.message
                  $scope.getUsers()
            ,(e) ->
              SweetAlert.swal("Opps!", "An error occurred Data not deleted", "error");

