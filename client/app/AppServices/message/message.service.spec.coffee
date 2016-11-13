'use strict'

describe 'Service: message', ->

  # load the service's module
  beforeEach module 'atlanticSolicitorsApp'

  # instantiate service
  message = undefined
  beforeEach inject (_message_) ->
    message = _message_

  it 'should do something', ->
    expect(!!message).toBe true
