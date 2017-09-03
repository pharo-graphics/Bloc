adding/removing
removeEventHandler: anHandler
	
	handlers
		ifNil: [ ^ self ].
	handlers remove: anHandler.
	"free memory as soon as we got rid of all event handlers"
	handlers isEmpty
		ifTrue: [ handlers := nil ].

	anHandler onUninstalledIn: self owner