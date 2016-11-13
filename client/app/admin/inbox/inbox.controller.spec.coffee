'use strict'

describe 'Controller: InboxCtrl', ->

  # load the controller's module
  beforeEach module 'atlanticSolicitorsApp'
  InboxCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    InboxCtrl = $controller 'InboxCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
