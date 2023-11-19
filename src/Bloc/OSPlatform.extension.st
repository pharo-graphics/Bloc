Extension { #name : 'OSPlatform' }

{ #category : '*Bloc' }
OSPlatform >> defaultScrollingVelocity [

	^ 20
]

{ #category : '*Bloc' }
OSPlatform >> primaryModifier [
	^ self subclassResponsibility
]

{ #category : '*Bloc' }
OSPlatform >> secondaryModifier [
	^ self subclassResponsibility
]
