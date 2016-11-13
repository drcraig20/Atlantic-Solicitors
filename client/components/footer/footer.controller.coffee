'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'FooterCtrl', ($scope, $location, NavBar,$rootScope, Message, toastr) ->
  $scope.submitting = false
  NavBar.query (result) ->
    $scope.navigation = result

  NavBar.getTestimony (response) ->
    $scope.testimonials = response


  $rootScope.contactForm = {}

  $rootScope.contactEmail = ()->
    Message.save $rootScope.contactForm, (response)->
      if response._id
        $scope.submitting = true
        toastr.success 'Message sent successfully'
    ,(e) ->
      $scope.submitting = false
      toastr.error 'Opps!!! Mail was not successfully sent'



