Class {
	#name : #BlDevScripterEventTarget,
	#superclass : #BlDevScripterTarget,
	#category : #'Bloc-DevTool-Scripter-Targets'
}

{ #category : #testing }
BlDevScripterEventTarget class >> isAbstract [
	^ self name = #BlDevScripterEventTarget 
]

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

{ #category : #updating }
BlDevScripterEventTarget >> updateUsing: aScripterEventTarget on: aStep [
	| aNestedTarget |
	aNestedTarget := BlDevScripterNestedChildEventTarget new.
	aNestedTarget targets: { self. aScripterEventTarget }.
	aStep target: aNestedTarget.
]
