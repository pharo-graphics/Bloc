Class {
	#name : 'BlDevScripterIndexedChildEventTarget',
	#superclass : 'BlDevScripterEventTarget',
	#instVars : [
		'index'
	],
	#category : 'Bloc-Scripter-Scripter-Targets'
}

{ #category : 'testing' }
BlDevScripterIndexedChildEventTarget class >> matchesWithInput: anObject [
	<return: #Boolean>
	^ anObject isInteger
]

{ #category : 'instance creation' }
BlDevScripterIndexedChildEventTarget class >> newFromInput: anObject [
	^ self new index: anObject
]

{ #category : 'searching' }
BlDevScripterIndexedChildEventTarget >> findTargetIn: anElement [
	<return: #BlElement>

	self
		assert: [ anElement notNil ]
		description: [ 'Element must not be nil' ].

	self 
		assert: [ self index between: 1 and: anElement childrenCount ]
		description: [ 'Child index ', self index asString, ' is out of bounds, must be between 1 and {1})' format: { anElement childrenCount } ].

	^ anElement children at: self index
]

{ #category : 'accessing' }
BlDevScripterIndexedChildEventTarget >> identifier [
	^ self index
]

{ #category : 'accessing' }
BlDevScripterIndexedChildEventTarget >> index [
	^ index
]

{ #category : 'accessing' }
BlDevScripterIndexedChildEventTarget >> index: anObject [
	index := anObject
]

{ #category : 'printing' }
BlDevScripterIndexedChildEventTarget >> printOn: aStream [
	self index ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Child At: ';
		print: self index.
]
