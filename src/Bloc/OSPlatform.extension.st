Extension { #name : #OSPlatform }

{ #category : #'*Bloc' }
OSPlatform >> blocKeyFor: aKeyValue in: aKeyTable [
	<return: #BlKeyboardKey>

	^ self subclassResponsibility
]

{ #category : #'*Bloc' }
OSPlatform >> primaryModifier [
	^ self subclassResponsibility
]

{ #category : #'*Bloc' }
OSPlatform >> secondaryModifier [
	^ self subclassResponsibility
]
