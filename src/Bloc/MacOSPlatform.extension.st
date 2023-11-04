Extension { #name : 'MacOSPlatform' }

{ #category : '*Bloc' }
MacOSPlatform >> primaryModifier [
	^ BlAlternativeCombination new
		key: KeyboardKey metaLeft;
		key: KeyboardKey metaRight;
		key: KeyboardKey superLeft;
		key: KeyboardKey superRight;
		yourself
]

{ #category : '*Bloc' }
MacOSPlatform >> secondaryModifier [
	^ BlAlternativeCombination new
		key: KeyboardKey controlLeft;
		key: KeyboardKey controlRight;
		yourself
]
