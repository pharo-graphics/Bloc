Class {
	#name : #BlDevScripterIndexedChildEventTarget,
	#superclass : #BlDevScripterEventTarget,
	#instVars : [
		'index'
	],
	#category : #'Bloc-DevTool-Scripter-Targets'
}

{ #category : #testing }
BlDevScripterIndexedChildEventTarget class >> matchesWithInput: anObject [
	<return: #Boolean>
	^ anObject isInteger
]

{ #category : #'instance creation' }
BlDevScripterIndexedChildEventTarget class >> newFromInput: anObject [
	^ self new index: anObject
]

{ #category : #searching }
BlDevScripterIndexedChildEventTarget >> findTargetIn: anElement [
	<return: #BlElement>

	self 
		assert: self index <= anElement childrenCount
		description: [ 'Index ', self index asString, ' is bigger than number of children' ].
	^ anElement children at: self index
]

{ #category : #accessing }
BlDevScripterIndexedChildEventTarget >> identifier [
	^ self index
]

{ #category : #accessing }
BlDevScripterIndexedChildEventTarget >> index [
	^ index
]

{ #category : #accessing }
BlDevScripterIndexedChildEventTarget >> index: anObject [
	index := anObject
]

{ #category : #printing }
BlDevScripterIndexedChildEventTarget >> printOn: aStream [
	self index ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Child At: ';
		print: self index.
]
