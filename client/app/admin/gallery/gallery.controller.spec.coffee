'use strict'

describe 'Controller: GalleryCtrl', ->

  # load the controller's module
  beforeEach module 'atlanticSolicitorsApp'
  GalleryCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    GalleryCtrl = $controller 'GalleryCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
