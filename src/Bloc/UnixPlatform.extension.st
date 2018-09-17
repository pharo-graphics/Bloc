Extension { #name : #UnixPlatform }

{ #category : #'*Bloc' }
UnixPlatform >> primaryModifier [
	^ BlAlternativeCombination new
		key: Key leftControl;
		key: Key rightControl;
		yourself
]

{ #category : #'*Bloc' }
UnixPlatform >> secondaryModifier [
	^ BlAlternativeCombination new
		key: Key leftAlt;
		key: Key rightAlt;
		yourself
]
