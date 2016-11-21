'use strict'

angular.module 'atlanticSolicitorsApp'
.config ($stateProvider) ->
  $stateProvider.state 'article',
    url: '/article?id'
    templateUrl: 'app/article/article.html'
    controller: 'ArticleCtrl'
    guestView: true
    title: 'Articles'
