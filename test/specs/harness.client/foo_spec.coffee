describe 'FOO', ->
  it 'does something', ->
    console.log 'My Test',123
    expect(1).toEqual 1

  it 'gets the root harness client', ->
    console.log 'harness', harness
    expect(harness).toBeDefined()

