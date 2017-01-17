'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'TestimonialCtrl', ($scope, Testimonial, SweetAlert) ->
  $scope.checkModel = {};
  $scope.ids = [];

  $scope.getTestimony = ()->
    Testimonial.query (result)->
      $scope.notApproved = _.filter(result,{'approved':false})
      $scope.approved = _.filter(result,{'approved':true})
      $scope.testimonials = result

  $scope.getTestimony()


  $scope.pushAndPop = (id)->
    if id not in $scope.ids
      $scope.ids.push id
    else if id in $scope.ids
      _.remove $scope.ids, (a)->
        a == id


  $scope.delete = ->
    if $scope.ids.length
      SweetAlert.swal {
        title: 'Are you sure?'
        text: if $scope.ids.length > 1 then 'These Testimonials will be permanently deleted' else 'This Testimonial will be permanently deleted'
        type: 'warning'
        showCancelButton: true
        confirmButtonColor: '#DD6B55'
        confirmButtonText: 'Yes, delete it!'
        closeOnConfirm: false
      },(isConfirm) ->
        if isConfirm
          Testimonial.dispose $scope.ids, (response)->
            if response
                SweetAlert.swal("Deleted!", response.message, "success");
                $scope.getTestimony()
          ,(e) ->
            SweetAlert.swal("Deleted!", "Data could not be deleted", "error");

  $scope.approveTestimonial =(t) ->
    Testimonial.update {id:t._id}, {approved: true}, (response)->
      if response
        SweetAlert.swal("Approved!", 'Testimonial successfully approved', "success");
        console.log response
        $scope.getTestimony()
