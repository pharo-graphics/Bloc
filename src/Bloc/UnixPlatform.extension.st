Extension { #name : #UnixPlatform }

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
