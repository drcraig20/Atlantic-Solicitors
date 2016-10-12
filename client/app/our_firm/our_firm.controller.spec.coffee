'use strict'

describe 'Controller: OurFirmCtrl', ->

  # load the controller's module
  beforeEach module 'atlanticSolicitorsApp'
  OurFirmCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    OurFirmCtrl = $controller 'OurFirmCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
