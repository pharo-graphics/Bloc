Class {
	#name : #BlDevScripterReversedEvents,
	#superclass : #BlDevScripterCollection,
	#category : #'Bloc-Scripter-Scripter-Utilities'
}

{ #category : #accessing }
BlDevScripterReversedEvents >> at: anIndex [
	^ self collection at: (self reversedIndexFrom: anIndex)
]

{ #category : #enumerating }
BlDevScripterReversedEvents >> detect: aBlock ifFound: foundBlock ifNone: exceptionBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	If some element evaluates aBlock to true, then cull this element into 
	foundBlock and answer the result of this evaluation. 
	If none evaluate to true, then evaluate exceptionBlock."

	self
		do: [ :each | 
			(aBlock value: each)
				ifTrue: [ ^ foundBlock cull: each ] ].
	^ exceptionBlock value
]

{ #category : #enumerating }
BlDevScripterReversedEvents >> do: aBlock [
	self collection reverseDo: aBlock
]

{ #category : #'gt-extension' }
BlDevScripterReversedEvents >> gtEventsFor: aView [
	<gtView>
	self collection ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Events';
		priority: 3;
		items: [ self ];
		column: 'Index'
			item:
				[ :eachItem :eachIndex | (self reversedIndexFrom: eachIndex) asRopedText foreground: Color gray ]
			width: 80;
		column: 'Item'
			item: [ :eachItem :eachIndex | eachItem ]
			text: [ :eachItem | eachItem gtDisplayText ]
]

{ #category : #accessing }
BlDevScripterReversedEvents >> reversedIndexFrom: anIndex [
	^ self size - anIndex + 1
]
