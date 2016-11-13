'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'AboutUsCtrl', ($scope, AboutUs,Profile) ->
  AboutUs.query (results)->
    $scope.about = results

  Profile.getProfiles {id:true},(results)->
    $scope.profiles = results








