Class {
	#name : #BlDevScripterCheckChildrenCountStep,
	#superclass : #BlDevScripterCheckStep,
	#instVars : [
		'childrenCount'
	],
	#category : 'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterCheckChildrenCountStep >> childrenCount [
	^ childrenCount
]

{ #category : #accessing }
BlDevScripterCheckChildrenCountStep >> childrenCount: aNumber [
	childrenCount := aNumber
]

{ #category : #accessing }
BlDevScripterCheckChildrenCountStep >> defaultLabel [
	^ 'Children'
]

{ #category : #printing }
BlDevScripterCheckChildrenCountStep >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ': ';
		nextPutAll: self childrenCount asString
]

{ #category : #actions }
BlDevScripterCheckChildrenCountStep >> validateOn: anElement [
	self assert: anElement childrenCount equals: self childrenCount
]
