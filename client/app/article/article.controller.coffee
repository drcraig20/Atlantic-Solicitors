'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'ArticleCtrl', ($scope, $stateParams, $rootScope,Article) ->
  if not $stateParams.id
    $rootScope.goToState('main')
  else
    Article.get id:$stateParams.id, (article)->
      $scope.article = article

