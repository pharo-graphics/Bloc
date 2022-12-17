Extension { #name : #UnixPlatform }

{ #category : #'*Bloc' }
UnixPlatform >> blocKeyFor: aKeyValue in: aKeyTable [
	<return: #BlKeyboardKey>
	self deprecated: 'No more specific system keyboard management in bloc'.

	^ aKeyTable valueForUnixPlatform: aKeyValue
]

{ #category : #'*Bloc' }
UnixPlatform >> primaryModifier [
	^ BlAlternativeCombination new
		key: KeyboardKey controlLeft;
		key: KeyboardKey controlRight;
		yourself
]

{ #category : #'*Bloc' }
UnixPlatform >> secondaryModifier [
	^ BlAlternativeCombination new
		key: KeyboardKey altLeft;
		key: KeyboardKey altRight;
		yourself
]
