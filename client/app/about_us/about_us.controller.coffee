'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'AboutUsCtrl', ($scope, AboutUs,Profile,$state) ->
  AboutUs.query (results)->
    $scope.about = results

  Profile.getProfiles {id:true},(results)->
    $scope.profiles = results


  $scope.go = (id)->
    console.log id
    $state.go 'profile',
      id:id







