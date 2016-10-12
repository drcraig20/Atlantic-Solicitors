'use strict'

describe 'Service: aboutUs', ->

  # load the service's module
  beforeEach module 'atlanticSolicitorsApp'

  # instantiate service
  aboutUs = undefined
  beforeEach inject (_aboutUs_) ->
    aboutUs = _aboutUs_

  it 'should do something', ->
    expect(!!aboutUs).toBe true
