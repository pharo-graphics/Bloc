Extension { #name : #MacOSXPlatform }

{ #category : #'*Bloc' }
MacOSXPlatform >> blocKeyFor: aKeyValue in: aKeyTable [
	<return: #BlKeyboardKey>
	self deprecated: 'No more specific system keyboard management in bloc'.
	^ aKeyTable valueForMacOSXPlatform: aKeyValue
]
