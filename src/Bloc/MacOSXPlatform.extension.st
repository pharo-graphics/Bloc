Extension { #name : #MacOSXPlatform }

{ #category : #'*Bloc' }
MacOSXPlatform >> blocKeyFor: aKeyValue in: aKeyTable [
	<return: #BlKeyboardKey>

	^ aKeyTable valueForMacOSXPlatform: aKeyValue
]
