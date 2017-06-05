'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'SentMailCtrl', ($scope, Message,$rootScope, SweetAlert, $uibModal, toastr) ->
  $scope.$State =  $rootScope.$state.current
  $scope.nextPage = 0
  $scope.limit = 10
  $scope.checkModel = {};
  $scope.ids = [];
  modal = null
  $scope.submitting = false


  $scope.loadSentMessage = ()->
    Message.query {nextPage:$scope.nextPage, limit:$scope.limit, status:'sent'}, (response)->
      $scope.messages = response

  $scope.loadSentMessage()


  $scope.nextMails = ->
    if $rootScope.count.totalSent > $scope.nextPage
      $scope.nextPage = $scope.nextPage + 10
      $scope.loadSentMessage()

  $scope.prevMails = ->
    if $scope.nextPage > 0
      $scope.nextPage = $scope.nextPage - 10
      $scope.loadSentMessage()



  $scope.cancel = ()->
    $scope.submitting = false
    modal.close()


  $scope.sendNewMessage = ()->
    $scope.toSend.subject = $scope.modalContent.subject
    $scope.toSend.to = $scope.modalContent.to
    $scope.toSend.reply = $scope.modalContent.reply
    Message.send  $scope.toSend, (result)->
      modal.close()
      if result.status is 1
        type = 'success'
        title = 'Success'
      else if result.status is 0
        title = 'Sorry!!!'
        type = 'error'
      SweetAlert.swal {
        title: title
        text: result.message
        type: type
      }
      $scope.toSend.reply = ''


  $scope.createMessage = ()->
    $scope.modalContent = {}
    modal = $uibModal.open
      templateUrl: 'app/admin/inbox/newMessage.html'
      backdrop: 'static'
      scope: $scope
      size: 'lg'

  $scope.openMessage =(message) ->
    $scope.singleMessage = message
    $scope.readMessage = true

  $scope.sendNewMessage = ()->
    $scope.toSend.subject = $scope.modalContent.subject
    $scope.toSend.to = $scope.modalContent.to
    $scope.toSend.reply = $scope.modalContent.reply
    Message.send  $scope.toSend, (result)->
      modal.close()
      if result.status is 1
        $scope.sentMessage($scope.toSend)
        type = 'success'
        title = 'Success'
      else if result.status is 0
        title = 'Sorry!!!'
        type = 'error'
      SweetAlert.swal {
        title: title
        text: result.message
        type: type
      }
      $scope.toSend.reply = ''


  $scope.cancel = ()->
    $scope.submitting = false
    modal.close()


  $scope.sentMessage = (message) ->
    content={
      content: message.reply,
      email:message.to,
      subject:message.subject
      status: 'sent'
      read:true
    }
    Message.save content, ()->


  $scope.pushAndPop = (id)->
    if id not in $scope.ids
      $scope.ids.push id
    else if id in $scope.ids
      _.remove $scope.ids, (a)->
        a == id


  $scope.delete = ->
    if $scope.ids.length
      SweetAlert.swal {
        title: 'Are you sure?'
        text: if $scope.ids.length > 1 then 'These messages will be permanently deleted' else 'This message will be permanently deleted'
        type: 'warning'
        showCancelButton: true
        confirmButtonColor: '#DD6B55'
        confirmButtonText: 'Yes, delete it!'
        closeOnConfirm: false
      },(isConfirm) ->
        if isConfirm
          Message.dispose $scope.ids, (response)->
                SweetAlert.swal("Deleted!", response.message, "success");
                toastr.success response.message
                $scope.loadSentMessage()
          ,(e) ->
            toastr.error 'Data Could Not be deleted.'
