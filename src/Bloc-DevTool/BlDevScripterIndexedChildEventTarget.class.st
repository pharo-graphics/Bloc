Class {
	#name : #BlDevScripterIndexedChildEventTarget,
	#superclass : #BlDevScripterEventTarget,
	#instVars : [
		'index'
	],
	#category : #'Bloc-DevTool-Scripter'
}

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
