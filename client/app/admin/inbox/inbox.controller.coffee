'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'InboxCtrl', ($scope, Message,$rootScope) ->
  Message.query (response)->
    $rootScope.messages = response

  $rootScope.getHeading = (msg)->
    if msg? and msg is undefined
      return ''
    if msg.length > 50
      return msg = msg.substring(0,50)+" ..."
    else
      return msg


  $scope.openMessage =(message) ->
    $scope.singleMessage = message
    console.log(message)
    $scope.readMessage = true




