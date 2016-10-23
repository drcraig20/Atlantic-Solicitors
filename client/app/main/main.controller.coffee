'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'MainCtrl', ($scope, Solicitor, $timeout) ->
  animation = [
    'slideAppearRightToLeft',
    'slideAppearLeftToRight',
    'slideAppearUpToDown',
    'slideAppearDownToUp',
  ]

  $scope.delay = 200

  $('.responsive-slider-parallax').responsiveSlider({
    autoplay: true,
    interval: 5000,
    transitionTime: 1000,
    parallax: false
  })

#  fetch images the url of images for the Slider from the server
  Solicitor.getDetails type:'SliderImage', (Images)->
    if Images.images.length
      $scope.Images = Images

  Solicitor.getDetails type:'BannerContent', (Content)->
    if Content
      $scope.content = Content
      $scope.anime = animation[_.random(0,animation.length-1)]


  ImagesReload = () ->
    if $scope.Images
      number = _.random(0,$scope.Images.images.length-1)
      $scope.sliderImage = $scope.Images.images[number]
      $timeout ()->
        ImagesReload()
        $scope.anime = animation[_.random(0,animation.length-1)]
      ,10000


  $timeout ()->
    ImagesReload()
  ,1000



