Class {
	#name : #BlDevScripterEventTarget,
	#superclass : #Object,
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #testing }
BlDevScripterEventTarget class >> matchesWithInput: anObject [
	<return: #Boolean>
	^ false
]

{ #category : #enumerating }
BlDevScripterEventTarget class >> targetInstanceFor: anObject [
	"I am used by ${class:BlDevScripterNestedChildEventTarget}$.
	I return a subclass that handles given input."
	<return: #BlDevScripterEventTarget>
	self subclassesDo: [ :eachSubclass | 
		(eachSubclass matchesWithInput: anObject) ifTrue: [ ^ eachSubclass newFromInput: anObject ] ].
	self error: 'Cannot find a suitable class for ', anObject printString.
]

{ #category : #searching }
BlDevScripterEventTarget >> findTargetIn: anElement [
	<return: #BlElement>

	^ self subclassResponsibility
]
