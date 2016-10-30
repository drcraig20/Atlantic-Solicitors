'use strict'

describe 'Controller: EditPageCtrl', ->

  # load the controller's module
  beforeEach module 'atlanticSolicitorsApp'
  EditPageCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    EditPageCtrl = $controller 'EditPageCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
