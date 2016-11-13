'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider.state 'gallery',
    url: '/admin/gallery'
    templateUrl: 'app/admin/gallery/gallery.html'
    controller: 'GalleryCtrl'
