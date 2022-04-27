Extension { #name : #WinPlatform }

{ #category : #'*Bloc' }
WinPlatform >> blocKeyFor: aKeyValue in: aKeyTable [
	<return: #BlKeyboardKey>
	self deprecated: 'No more specific system keyboard management in bloc'.

	^ aKeyTable valueForWindowsPlatform: aKeyValue
]

{ #category : #'*Bloc' }
WinPlatform >> primaryModifier [
	^ BlAlternativeCombination new
		key: KeyboardKey controlLeft;
		key: KeyboardKey controlRight;
		yourself
]

{ #category : #'*Bloc' }
WinPlatform >> secondaryModifier [
	^ BlAlternativeCombination new
		key: KeyboardKey altLeft;
		key: KeyboardKey altRight;
		yourself
]
