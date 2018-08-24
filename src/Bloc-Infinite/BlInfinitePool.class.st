"
I represent a pool of objects
"
Class {
	#name : #BlInfinitePool,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : 'Bloc-Infinite-Pool'
}

{ #category : #pool }
BlInfinitePool >> acquire [
	^ self subclassResponsibility
]

{ #category : #pool }
BlInfinitePool >> release: anObject [
	^ self subclassResponsibility
]
