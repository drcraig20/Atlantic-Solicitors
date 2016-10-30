'use strict'

describe 'Controller: SigninCtrl', ->

  # load the controller's module
  beforeEach module 'atlanticSolicitorsApp'
  SigninCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    SigninCtrl = $controller 'SigninCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
