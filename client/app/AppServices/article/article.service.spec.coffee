'use strict'

describe 'Service: article', ->

  # load the service's module
  beforeEach module 'atlanticSolicitorsApp'

  # instantiate service
  article = undefined
  beforeEach inject (_article_) ->
    article = _article_

  it 'should do something', ->
    expect(!!article).toBe true
