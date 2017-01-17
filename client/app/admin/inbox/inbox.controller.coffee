'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'InboxCtrl', ($scope, Message,$rootScope, SweetAlert, $uibModal) ->
  $scope.nextPage = 0
  $scope.limit = 10
  modal = null
  $scope.submitting = false

  $scope.toSend = {}
  $scope.lodMessage = ()->
    Message.query {nextPage:$scope.nextPage, limit:$scope.limit}, (response)->
      $rootScope.messages = response
      console.log response

  $scope.lodMessage()

  $scope.nextMails = ->
    if $rootScope.count.total > $scope.nextPage
      $scope.nextPage = $scope.nextPage + 10
      $scope.lodMessage()

  $scope.prevMails = ->
    if $scope.nextPage > 0
      $scope.nextPage = $scope.nextPage - 10
      $scope.lodMessage()

  $rootScope.getHeading = (msg)->
    if msg? and msg is undefined
      return ''
    if msg.length > 50
      return msg = msg.substring(0,50)+" ..."
    else
      return msg


  $scope.openMessage =(message) ->
    if message.__v then delete message.__v
    if message.read is false
      message.read = true
      Message.update  id:message._id , message,() ->
    $scope.singleMessage = message
    $scope.readMessage = true
    Message.stat (count) ->
      $rootScope.count = count

  $scope.sendMessage = ()->
    $scope.toSend.subject = "RE: "+$scope.singleMessage.subject
    $scope.toSend.to = $scope.singleMessage.email
    Message.send  $scope.toSend, (result)->
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
#        showCancelButton: true
#        confirmButtonColor: '#DD6B55'
#        confirmButtonText: 'Yes, delete it!'
#        closeOnConfirm: false
      }
      $scope.toSend.reply = ''


  $scope.createMessage = ()->
    $scope.modalContent = {}
    modal = $uibModal.open
      templateUrl: 'app/admin/inbox/newMessage.html'
      backdrop: 'static'
      scope: $scope
      size: 'lg'


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


  $scope.cancel = ()->
    $scope.submitting = false
    modal.close()
