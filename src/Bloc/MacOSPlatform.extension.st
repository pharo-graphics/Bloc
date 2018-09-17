Extension { #name : #MacOSPlatform }

{ #category : #'*Bloc' }
MacOSPlatform >> primaryModifier [
	^ BlAlternativeCombination new
		key: Key leftMeta;
		key: Key rightMeta;
		yourself
]

{ #category : #'*Bloc' }
MacOSPlatform >> secondaryModifier [
	^ BlAlternativeCombination new
		key: Key leftControl;
		key: Key rightControl;
		yourself
]
