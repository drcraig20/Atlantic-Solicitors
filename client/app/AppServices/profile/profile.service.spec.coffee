'use strict'

describe 'Service: profile', ->

  # load the service's module
  beforeEach module 'atlanticSolicitorsApp'

  # instantiate service
  profile = undefined
  beforeEach inject (_profile_) ->
    profile = _profile_

  it 'should do something', ->
    expect(!!profile).toBe true
