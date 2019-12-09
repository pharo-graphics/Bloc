Class {
	#name : #BlDevScripterCheckChildrenCountStep,
	#superclass : #BlDevScripterCheckStep,
	#instVars : [
		'childrenCount'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #accessing }
BlDevScripterCheckChildrenCountStep >> childrenCount [
	^ childrenCount
]

{ #category : #accessing }
BlDevScripterCheckChildrenCountStep >> childrenCount: aNumber [
	childrenCount := aNumber
]

{ #category : #printing }
BlDevScripterCheckChildrenCountStep >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	aStream
		nextPutAll: ': ';
		nextPutAll: self childrenCount asString
]

{ #category : #accessing }
BlDevScripterCheckChildrenCountStep >> label [
	^ 'Children'
]

{ #category : #actions }
BlDevScripterCheckChildrenCountStep >> validateOn: anElement [
	self assert: anElement childrenCount equals: self childrenCount
]
