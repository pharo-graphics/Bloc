api - adding/removing
removeEventHandlersSuchThat: aBlock
	"remove all event handlers for those aBlock returns true"
	| toBeRemoved |
	handlers
		ifNil: [ ^ self ].
	
	toBeRemoved := handlers removeAllSuchThat: aBlock.
	handlers isEmpty
		ifTrue: [ handlers := nil ].
	
	self hasOwner
		ifTrue: [ toBeRemoved do: [ :aHandler | aHandler onUninstalledIn: self owner ] ]