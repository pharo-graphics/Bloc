"
I describe which phase the event flow is currently being evaluated.

"
Class {
	#name : #BlEventTraversalStep,
	#superclass : #Object,
	#instVars : [
		'target'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Events'
}

{ #category : #accessing }
BlEventTraversalStep class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
BlEventTraversalStep >> dispatcher [
	^ self target eventDispatcher
]

{ #category : #printing }
BlEventTraversalStep >> printOn: stream [
	super printOn: stream.
	self target ifNotNil: [ 
		stream nextPut: $(.
		self target printOn: stream.
		stream nextPut: $). ]
]

{ #category : #accessing }
BlEventTraversalStep >> target [
	^ target
]

{ #category : #accessing }
BlEventTraversalStep >> target: anObject [
	target := anObject
]

{ #category : #accessing }
BlEventTraversalStep >> type [
	<return: #String>
	
	^ self subclassResponsibility
]
