'use strict'

describe 'Controller: OurServiceCtrl', ->

  # load the controller's module
  beforeEach module 'atlanticSolicitorsApp'
  OurServiceCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    OurServiceCtrl = $controller 'OurServiceCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
