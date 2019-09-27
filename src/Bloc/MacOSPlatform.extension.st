Extension { #name : #MacOSPlatform }

{ #category : #'*Bloc' }
MacOSPlatform >> primaryModifier [
	^ BlAlternativeCombination new
		key: BlKeyboardKey metaLeft;
		key: BlKeyboardKey metaRight;
		yourself
]

{ #category : #'*Bloc' }
MacOSPlatform >> secondaryModifier [
	^ BlAlternativeCombination new
		key: BlKeyboardKey controlLeft;
		key: BlKeyboardKey controlRight;
		yourself
]
