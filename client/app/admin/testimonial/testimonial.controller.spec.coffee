'use strict'

describe 'Controller: TestimonialCtrl', ->

  # load the controller's module
  beforeEach module 'atlanticSolicitorsApp'
  TestimonialCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    TestimonialCtrl = $controller 'TestimonialCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
