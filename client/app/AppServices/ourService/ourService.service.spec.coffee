'use strict'

describe 'Service: ourService', ->

  # load the service's module
  beforeEach module 'atlanticSolicitorsApp'

  # instantiate service
  ourService = undefined
  beforeEach inject (_ourService_) ->
    ourService = _ourService_

  it 'should do something', ->
    expect(!!ourService).toBe true
