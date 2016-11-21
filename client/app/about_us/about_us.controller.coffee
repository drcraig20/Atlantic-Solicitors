'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'AboutUsCtrl', ($scope, AboutUs,Profile) ->
  AboutUs.query (results)->
    $scope.about = results

  Profile.getProfiles {id:true},(results)->
    $scope.profiles = results

  # get 200 characters
  $scope.getDescription = (msg)->
    if msg? and msg is undefined
      return ''
    if msg.length > 80
      return msg = msg.substring(0,80)+" ..."
    else
      return msg








