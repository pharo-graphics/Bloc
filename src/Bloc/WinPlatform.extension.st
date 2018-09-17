Extension { #name : #WinPlatform }

{ #category : #'*Bloc' }
WinPlatform >> primaryModifier [
	^ BlAlternativeCombination new
		key: Key leftControl;
		key: Key rightControl;
		yourself
]

{ #category : #'*Bloc' }
WinPlatform >> secondaryModifier [
	^ BlAlternativeCombination new
		key: Key leftAlt;
		key: Key rightAlt;
		yourself
]
