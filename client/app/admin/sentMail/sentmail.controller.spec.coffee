'use strict'

describe 'Controller: SentMailCtrl', ->

  # load the controller's module
  beforeEach module 'atlanticSolicitorsApp'
  SentMailCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    SentMailCtrl = $controller 'SentMailCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
