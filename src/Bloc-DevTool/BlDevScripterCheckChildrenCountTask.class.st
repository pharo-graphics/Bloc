Class {
	#name : #BlDevScripterCheckChildrenCountTask,
	#superclass : #BlDevScripterCheckTask,
	#instVars : [
		'childrenCount'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #accessing }
BlDevScripterCheckChildrenCountTask >> childrenCount [
	^ childrenCount
]

{ #category : #accessing }
BlDevScripterCheckChildrenCountTask >> childrenCount: aNumber [
	childrenCount := aNumber
]

{ #category : #printing }
BlDevScripterCheckChildrenCountTask >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	aStream
		nextPutAll: ': ';
		nextPutAll: self childrenCount asString
]

{ #category : #accessing }
BlDevScripterCheckChildrenCountTask >> label [
	^ 'Children'
]

{ #category : #actions }
BlDevScripterCheckChildrenCountTask >> validateOn: anElement [
	self assert: anElement childrenCount equals: self childrenCount
]
