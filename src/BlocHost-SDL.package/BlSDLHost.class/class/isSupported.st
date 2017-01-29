driver selection
isSupported
	^ SDL2 isAvailable and: [ Smalltalk hasClassNamed: 'SpartaCanvas' ]