Class {
	#name : #BlDevScripterNamedChildEventTarget,
	#superclass : #BlDevScripterEventTarget,
	#instVars : [
		'name'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #testing }
BlDevScripterNamedChildEventTarget class >> matchesWithInput: anObject [
	<return: #Boolean>
	^ anObject isString and: [ anObject isSymbol not ]
]

{ #category : #'instance creation' }
BlDevScripterNamedChildEventTarget class >> newFromInput: anObject [
	^ self new name: anObject
]

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
