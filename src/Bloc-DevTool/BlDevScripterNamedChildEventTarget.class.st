Class {
	#name : #BlDevScripterNamedChildEventTarget,
	#superclass : #BlDevScripterEventTarget,
	#instVars : [
		'name'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #searching }
BlDevScripterNamedChildEventTarget >> findTargetIn: anElement [
	<return: #BlElement>

	^ anElement childNamed: self name
]

{ #category : #accessing }
BlDevScripterNamedChildEventTarget >> name [
	^ name
]

{ #category : #accessing }
BlDevScripterNamedChildEventTarget >> name: anObject [
	name := anObject
]
