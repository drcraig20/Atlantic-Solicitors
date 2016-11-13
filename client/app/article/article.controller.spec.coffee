'use strict'

describe 'Controller: ArticleCtrl', ->

  # load the controller's module
  beforeEach module 'atlanticSolicitorsApp'
  ArticleCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ArticleCtrl = $controller 'ArticleCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
