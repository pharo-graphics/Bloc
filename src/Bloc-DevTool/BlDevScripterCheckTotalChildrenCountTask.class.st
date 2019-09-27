Class {
	#name : #BlDevScripterCheckTotalChildrenCountTask,
	#superclass : #BlDevScripterCheckTask,
	#instVars : [
		'totalChildrenCount'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #printing }
BlDevScripterCheckTotalChildrenCountTask >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	aStream
		nextPutAll: ': ';
		nextPutAll: self totalChildrenCount asString
]

{ #category : #accessing }
BlDevScripterCheckTotalChildrenCountTask >> label [
	^ 'Total children'
]

{ #category : #accessing }
BlDevScripterCheckTotalChildrenCountTask >> totalChildrenCount [
	^ totalChildrenCount
]

{ #category : #accessing }
BlDevScripterCheckTotalChildrenCountTask >> totalChildrenCount: aNumber [
	totalChildrenCount := aNumber
]

{ #category : #actions }
BlDevScripterCheckTotalChildrenCountTask >> validateOn: anElement [
	self assert: anElement withAllChildrenBreadthFirst size - 1 equals: self totalChildrenCount
]
