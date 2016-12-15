testing
partiallyMatch: anEventBuffer
	^ alternative anySatisfy: [ :each | each partiallyMatch: anEventBuffer ]