describe 'server/harness', ->

  it 'exists', ->
    expect(harness).toBeDefined()
    expect(test.server).toEqual harness

  it 'exposes the client libraries', ->
    client = require harness.paths.client
    expect(client).toBeDefined()
    expect(harness.client).toEqual client



