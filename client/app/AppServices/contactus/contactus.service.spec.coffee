'use strict'

describe 'Service: contactus', ->

  # load the service's module
  beforeEach module 'atlanticSolicitorsApp'

  # instantiate service
  contactus = undefined
  beforeEach inject (_contactus_) ->
    contactus = _contactus_

  it 'should do something', ->
    expect(!!contactus).toBe true
