'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'InboxCtrl', ($scope, Message,$rootScope, SweetAlert, $uibModal,toastr,Utils) ->
  $scope.$State =  $rootScope.$state.current
  $scope.nextPage = 0
  $scope.limit = 10
  $scope.checkModel = {};
  $scope.ids = [];
  modal = null
  $scope.submitting = false

  $scope.toSend = {}
  $scope.lodMessage = ()->
    Message.query {nextPage:$scope.nextPage, limit:$scope.limit, status:'receive'}, (response)->
      $rootScope.messages = response

  $scope.lodMessage()


  $scope.nextMails = ->
    console.log $rootScope.count.totalReceive
    if $rootScope.count.totalReceive > $scope.nextPage
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
      msg = Utils.stripTags(msg)
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
            $scope.lodMessage()
          ,(e) ->
            toastr.error 'Data Could Not be deleted.'

  $scope.pushAndPop = (id)->
    if id not in $scope.ids
      $scope.ids.push id
    else if id in $scope.ids
      _.remove $scope.ids, (a)->
        a == id
