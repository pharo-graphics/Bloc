testing
isSupported
	^ SDL2 isAvailable and: [ Smalltalk hasClassNamed: 'AthensCanvas' ]