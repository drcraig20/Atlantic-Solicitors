'use strict'

describe 'Controller: StaffProfileCtrl', ->

  # load the controller's module
  beforeEach module 'atlanticSolicitorsApp'
  StaffProfileCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    StaffProfileCtrl = $controller 'StaffProfileCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
