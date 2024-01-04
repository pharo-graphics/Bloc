Class {
	#name : #BlDevScripterCheckTotalChildrenCountStep,
	#superclass : #BlDevScripterCheckStep,
	#instVars : [
		'totalChildrenCount'
	],
	#category : 'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterCheckTotalChildrenCountStep >> defaultLabel [
	^ 'Total Children'
]

{ #category : #printing }
BlDevScripterCheckTotalChildrenCountStep >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ': ';
		nextPutAll: self totalChildrenCount asString
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
