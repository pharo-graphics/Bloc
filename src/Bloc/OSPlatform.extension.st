Extension { #name : #OSPlatform }

{ #category : #'*Bloc' }
OSPlatform >> blocKeyFor: aKeyValue in: aKeyTable [
	<return: #BlKeyboardKey>
	self deprecated: 'No more specific system keyboard management in bloc'.

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
