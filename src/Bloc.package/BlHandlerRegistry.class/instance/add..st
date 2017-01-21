adding / removing
add: aHandler
	"Adds a given event handler to the registry.
	aHandler must not be nil and must not be already registered"
	
	self
		assert: [ aHandler isNotNil ]
		description: [ 'Handler must not be nil!' ].

	self
		assert: [ (handlers includes: aHandler) not ]
		description: [ 'Handler must not be registered!' ].

	handlers := handlers copyWith: aHandler