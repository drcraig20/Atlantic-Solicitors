'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'FooterCtrl', ($scope, $location, NavBar,$rootScope, Message, toastr, $uibModal, SweetAlert,Testimonial) ->
  $scope.submitting = false
  modal = null


  $scope.cancel = ()->
    $scope.submitting = false
    modal.close()


  NavBar.query (result) ->
    $scope.navigation = result

  NavBar.getTestimony (response) ->
    $scope.testimonials = response

  $scope.year = moment().year()


  $rootScope.contactEmail = (contactForm)->
    $scope.submitting = true
    content={
      content: contactForm.content,
      name:contactForm.name,
      email:contactForm.email,
      subject:contactForm.subject
    }
    Message.save content, (response)->
      if response._id
        $scope.submitting = false
        toastr.success 'Message sent successfully'
    ,(e) ->
      $scope.submitting = false
      toastr.error 'Opps!!! Mail was not successfully sent'

  $scope.createFeedback = ()->
    $scope.testimonial = {}
    modal = $uibModal.open
      templateUrl: 'components/footer/feedbackModal.html'
      backdrop: 'static'
      scope: $scope
      size: 'md'

  $scope.sendFeedback = ()->
    $scope.submitting = true
    Testimonial.save  $scope.testimonial, (result)->
      modal.close()
      if result._id
        type = 'success'
        title = 'Success'
        message = 'Feedback successfully submitted for approval.'
      else
        title = 'Sorry!!!'
        type = 'error'
        message = 'An error occurred, feedback not submitted.'
      SweetAlert.swal {
        title: title
        text: message
        type: type
      }
      $scope.submitting = false
      $scope.testimonial = {}


