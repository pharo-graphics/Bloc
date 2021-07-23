Extension { #name : 'WinPlatform' }

{ #category : '*Bloc' }
WinPlatform >> blocKeyFor: aKeyValue in: aKeyTable [
	<return: #BlKeyboardKey>

	^ aKeyTable valueForWindowsPlatform: aKeyValue
]

{ #category : '*Bloc' }
WinPlatform >> primaryModifier [
	^ BlAlternativeCombination new
		key: BlKeyboardKey controlLeft;
		key: BlKeyboardKey controlRight;
		yourself
]

{ #category : '*Bloc' }
WinPlatform >> secondaryModifier [
	^ BlAlternativeCombination new
		key: BlKeyboardKey altLeft;
		key: BlKeyboardKey altRight;
		yourself
]
