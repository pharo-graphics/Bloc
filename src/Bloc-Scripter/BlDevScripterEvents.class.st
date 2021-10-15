Class {
	#name : #BlDevScripterEvents,
	#superclass : #BlDevScripterCollection,
	#category : #'Bloc-Scripter-Scripter-Utilities'
}

{ #category : #adding }
BlDevScripterEvents >> add: anEvent [
	self 
		assert: [ anEvent isNotNil ]
		description: [ 'Event must be non-nil' ].
	
	(self collection includes: anEvent)
		ifFalse: [ self collection add: anEvent ]
]

{ #category : #converting }
BlDevScripterEvents >> asArray [
	^ self collection asArray
]

{ #category : #accessing }
BlDevScripterEvents >> at: anIndex [
	^ self collection at: anIndex
]

{ #category : #enumerating }
BlDevScripterEvents >> detect: aBlock ifFound: foundBlock ifNone: exceptionBlock [
	^ self collection detect: aBlock ifFound: foundBlock ifNone: exceptionBlock
]

{ #category : #enumerating }
BlDevScripterEvents >> do: aBlock [
	self collection do: aBlock
]

{ #category : #converting }
BlDevScripterEvents >> reversed [
	^ BlDevScripterReversedEvents new collection: self collection.
]

{ #category : #enumerating }
BlDevScripterEvents >> select: aBlock [ 
	^ self collection select: aBlock 
]
