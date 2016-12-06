'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'AboutUsCtrl', ($scope, AboutUs,Profile,$anchorScroll,$location) ->
  AboutUs.query (results)->
    $scope.about = results
  
  $scope.showing = false;

  Profile.getProfiles {id:true},(results)->
    $scope.profiles = results

  $scope.profileView = false

  $scope.back = ->
    $scope.profileView = false
    $scope.gotoAnchor('us')

  $scope.getProfile =(id) ->
    Profile.get id:id,(result) ->
      $scope.user = result
      $scope.profileView = true
      $('html, body').animate({ scrollTop: 0 }, 200)


  # get 200 characters
  $scope.getDescription = (msg)->
    if msg? and msg is undefined
      return ''
    if msg.length > 80
      return msg = msg.substring(0,80)+" ..."
    else
      return msg

  $scope.gotoAnchor = (x) ->
    $location.hash x






