updating
updateProgress: aNumber max: aMaxNumber
	BlUniverse defer: [ self privateProgress: (aNumber / aMaxNumber) asFloat ]