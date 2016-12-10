initialization
assignCoordinateFromPaddingIn: aLinearLayout
	| anOrientation |
	
	anOrientation := aLinearLayout orientation.
	coordinate := layoutFromEnd
		ifTrue: [ anOrientation endWithPadding ]
		ifFalse: [ anOrientation startWithPadding ]