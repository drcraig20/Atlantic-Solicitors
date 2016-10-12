'use strict'

describe 'Service: ourFirm', ->

  # load the service's module
  beforeEach module 'atlanticSolicitorsApp'

  # instantiate service
  ourFirm = undefined
  beforeEach inject (_ourFirm_) ->
    ourFirm = _ourFirm_

  it 'should do something', ->
    expect(!!ourFirm).toBe true
