Extension { #name : #WinPlatform }

{ #category : #'*Bloc' }
WinPlatform >> defaultScrollingVelocity [

	^ 100
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
