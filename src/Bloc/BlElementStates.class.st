"
!Current element states
"
Class {
	#name : #BlElementStates,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'element',
		'localStates',
		'inheritedStates'
	],
	#category : #'Bloc-Basic-State'
}

{ #category : #adding }
BlElementStates >> addState: aBlElementState [
	localStates add: aBlElementState.
	self element requestStyle.
	self onStatesChanged
]

{ #category : #accessing }
BlElementStates >> allStates [
	^ localStates copy, inheritedStates
]

{ #category : #accessing }
BlElementStates >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
BlElementStates >> element [
	^ element
]

{ #category : #accessing }
BlElementStates >> element: anObject [
	element := anObject
]

{ #category : #accessing }
BlElementStates >> inheritedStates: aSetOfStates [
	inheritedStates := aSetOfStates
]

{ #category : #initialization }
BlElementStates >> initialize [
	super initialize.
	
	localStates := Set new.
	inheritedStates := Set new
]

{ #category : #private }
BlElementStates >> onStatesChanged [

	"Just to keep it very simple"
	announcer
		ifNil: [ ^ self ].
	announcer announce: #statesChanged
]

{ #category : #adding }
BlElementStates >> removeState: aBlElementState [
	localStates
		remove: aBlElementState
		ifAbsent: [ ^ self ].

	self element requestStyle.
	self onStatesChanged
]

{ #category : #accessing }
BlElementStates >> statesToInherit [
	^ self allStates select: [ :eachState | eachState shouldPropagateToChildren ]
]
