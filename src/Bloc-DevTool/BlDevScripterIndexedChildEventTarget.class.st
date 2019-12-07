Class {
	#name : #BlDevScripterIndexedChildEventTarget,
	#superclass : #BlDevScripterEventTarget,
	#instVars : [
		'index'
	],
	#category : #'Bloc-DevTool-Scripter'
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

	^ anElement children at: self index
]

{ #category : #accessing }
BlDevScripterIndexedChildEventTarget >> index [
	^ index
]

{ #category : #accessing }
BlDevScripterIndexedChildEventTarget >> index: anObject [
	index := anObject
]
