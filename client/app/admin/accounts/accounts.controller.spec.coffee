'use strict'

describe 'Controller: AccountsCtrl', ->

  # load the controller's module
  beforeEach module 'atlanticSolicitorsApp'
  AccountsCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    AccountsCtrl = $controller 'AccountsCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
