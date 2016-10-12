'use strict'

describe 'Controller: ContactUsCtrl', ->

  # load the controller's module
  beforeEach module 'atlanticSolicitorsApp'
  ContactUsCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ContactUsCtrl = $controller 'ContactUsCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
