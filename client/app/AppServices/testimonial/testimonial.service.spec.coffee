'use strict'

describe 'Service: testimonial', ->

  # load the service's module
  beforeEach module 'atlanticSolicitorsApp'

  # instantiate service
  testimonial = undefined
  beforeEach inject (_testimonial_) ->
    testimonial = _testimonial_

  it 'should do something', ->
    expect(!!testimonial).toBe true
