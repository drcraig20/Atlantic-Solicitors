'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'EditPageCtrl', ($scope, $stateParams,$injector,NavBar) ->
  $scope.obj = $stateParams
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
      
