"
I represent a pool of objects
"
Class {
	#name : #BlObjectPool,
	#superclass : #Object,
	#category : #'Bloc-Basic-Support'
}

{ #category : #pool }
BlObjectPool >> acquire [
	^ self subclassResponsibility
]

{ #category : #pool }
BlObjectPool >> release: anObject [
	^ self subclassResponsibility
]
