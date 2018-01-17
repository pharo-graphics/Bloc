api - adding / removing
remove: aHandler
	"Remove given event handler from my registry.
	Provided handler must not be nil and must be registered"
	
	self
		assert: [ aHandler isNotNil ]
		description: [ 'Handler must not be nil!' ].

	self
		assert: [ handlers includes: aHandler ]
		description: [ 'Handler must be registered!' ].

	handlers := handlers copyWithout: aHandler