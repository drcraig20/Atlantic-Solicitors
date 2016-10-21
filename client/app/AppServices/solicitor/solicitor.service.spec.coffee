'use strict'

describe 'Service: solicitor', ->

  # load the service's module
  beforeEach module 'atlanticSolicitorsApp'

  # instantiate service
  solicitor = undefined
  beforeEach inject (_solicitor_) ->
    solicitor = _solicitor_

  it 'should do something', ->
    expect(!!solicitor).toBe true
