'use strict'

describe 'Service: accounts', ->

  # load the service's module
  beforeEach module 'atlanticSolicitorsApp'

  # instantiate service
  accounts = undefined
  beforeEach inject (_accounts_) ->
    accounts = _accounts_

  it 'should do something', ->
    expect(!!accounts).toBe true
