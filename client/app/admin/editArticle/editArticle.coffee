'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider.state 'editArticle',
    url: '/admin/article'
    templateUrl: 'app/admin/editArticle/editArticle.html'
    controller: 'EditArticleCtrl'
    title: 'Articles'

