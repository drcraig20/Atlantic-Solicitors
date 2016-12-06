'use strict'

describe 'Service: fileUpload', ->

  # load the service's module
  beforeEach module 'atlanticSolicitorsApp'

  # instantiate service
  fileUpload = undefined
  beforeEach inject (_fileUpload_) ->
    fileUpload = _fileUpload_

  it 'should do something', ->
    expect(!!fileUpload).toBe true
