initialization
initializeWith: aBlEventDispatcher

	self
		assert: [ dispatcher isNil ]
		description: [ 'I am immutable. Create a new chain for a given dispatcher' ].

	dispatcher := aBlEventDispatcher.
	
	"explicitly log that new chain has no successor or predecessor"
	previous := nil.
	next := nil