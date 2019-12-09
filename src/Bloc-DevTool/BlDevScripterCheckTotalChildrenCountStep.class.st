Class {
	#name : #BlDevScripterCheckTotalChildrenCountStep,
	#superclass : #BlDevScripterCheckStep,
	#instVars : [
		'totalChildrenCount'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #printing }
BlDevScripterCheckTotalChildrenCountStep >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	aStream
		nextPutAll: ': ';
		nextPutAll: self totalChildrenCount asString
]

{ #category : #accessing }
BlDevScripterCheckTotalChildrenCountStep >> label [
	^ 'Total children'
]

{ #category : #accessing }
BlDevScripterCheckTotalChildrenCountStep >> totalChildrenCount [
	^ totalChildrenCount
]

{ #category : #accessing }
BlDevScripterCheckTotalChildrenCountStep >> totalChildrenCount: aNumber [
	totalChildrenCount := aNumber
]

{ #category : #actions }
BlDevScripterCheckTotalChildrenCountStep >> validateOn: anElement [
	self assert: anElement withAllChildrenBreadthFirst size - 1 equals: self totalChildrenCount
]
