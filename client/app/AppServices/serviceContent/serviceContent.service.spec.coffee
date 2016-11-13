'use strict'

describe 'Service: serviceContent', ->

  # load the service's module
  beforeEach module 'atlanticSolicitorsApp'

  # instantiate service
  serviceContent = undefined
  beforeEach inject (_serviceContent_) ->
    serviceContent = _serviceContent_

  it 'should do something', ->
    expect(!!serviceContent).toBe true
