"
I represent a pool of objects

"
Class {
	#name : 'BlObjectPool',
	#superclass : 'Object',
	#package : 'Bloc',
	#tag : 'Basic-Support'
}

{ #category : 'pool' }
BlObjectPool >> acquire [
	^ self subclassResponsibility
]

{ #category : 'pool' }
BlObjectPool >> release: anObject [
	^ self subclassResponsibility
]
