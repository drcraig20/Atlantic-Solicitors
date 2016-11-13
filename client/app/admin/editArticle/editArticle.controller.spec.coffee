'use strict'

describe 'Controller: EditArticleCtrl', ->

  # load the controller's module
  beforeEach module 'atlanticSolicitorsApp'
  EditArticleCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    EditArticleCtrl = $controller 'EditArticleCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
