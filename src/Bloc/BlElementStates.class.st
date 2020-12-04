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
	"Add a given local state overwriting any existing one of the same type"

	(localStates hasState: aBlElementState)
		ifTrue: [ ^ self ].

	localStates remove: aBlElementState ifAbsent: [  ].
	localStates add: aBlElementState.
	aBlElementState optionalOnAddedTo: self element.

	self element requestStyle.
	self onStatesChanged
]

{ #category : #accessing }
BlElementStates >> allStates [
	<return: #BlElementStatesSet>

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

{ #category : #testing }
BlElementStates >> hasState: aBlElementState [
	<return: #Boolean>

	^ localStates hasState: aBlElementState
]

{ #category : #accessing }
BlElementStates >> inheritedStates: aSetOfStates [
	self
		assert: [ aSetOfStates isKindOf: BlElementStatesSet ]
		description: [ 'Set of states must be a special collection' ].

	inheritedStates := aSetOfStates.
	self onStatesChanged
]

{ #category : #initialization }
BlElementStates >> initialize [
	super initialize.
	
	localStates := BlElementStatesSet new.
	inheritedStates := BlElementStatesSet new
]

{ #category : #testing }
BlElementStates >> isDisabled [
	<return: #Boolean>

	^ self hasState: BlElementState disabled
]

{ #category : #testing }
BlElementStates >> isEnabled [
	^ self isDisabled not
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
	"remove all state of the same type"
	localStates
		remove: aBlElementState
		ifAbsent: [ ^ self ].

	self element requestStyle.
	self onStatesChanged
]

{ #category : #adding }
BlElementStates >> removeStatesSuchThat: aBlock [
	| sizeBefore |
	sizeBefore := localStates size.
	localStates removeAllSuchThat: aBlock.
	sizeBefore = localStates size
		ifTrue: [ ^ self ].

	self element requestStyle.
	self onStatesChanged
]

{ #category : #accessing }
BlElementStates >> statesToInherit [
	<return: #BlElementStatesSet>

	^ self allStates select: [ :eachState | eachState shouldPropagateToChildren ]
]
