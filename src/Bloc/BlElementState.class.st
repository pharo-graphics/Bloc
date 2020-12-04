Class {
	#name : #BlElementState,
	#superclass : #Object,
	#classVars : [
		'UserPriority'
	],
	#category : #'Bloc-Basic-State'
}

{ #category : #'instance creation' }
BlElementState class >> collapsed [
	^ BlElementCollapsedState uniqueInstance
]

{ #category : #'instance creation' }
BlElementState class >> default [
	^ BlElementDefaultState uniqueInstance
]

{ #category : #'instance creation' }
BlElementState class >> deselected [
	^ self selected not
]

{ #category : #'instance creation' }
BlElementState class >> disabled [
	^ BlElementDisabledState uniqueInstance
]

{ #category : #'instance creation' }
BlElementState class >> enabled [
	^ self disabled not
]

{ #category : #'instance creation' }
BlElementState class >> expanded [
	^ BlElementExpandedState uniqueInstance
]

{ #category : #'instance creation' }
BlElementState class >> focused [
	^ BlElementFocusedState uniqueInstance
]

{ #category : #'instance creation' }
BlElementState class >> hovered [
	^ BlElementHoveredState uniqueInstance
]

{ #category : #'class initialization' }
BlElementState class >> initialize [
	UserPriority := 50
]

{ #category : #'instance creation' }
BlElementState class >> pressed [
	^ BlElementPressedState uniqueInstance
]

{ #category : #'instance creation' }
BlElementState class >> selected [
	^ BlElementSelectedState uniqueInstance
]

{ #category : #'instance creation' }
BlElementState class >> unfocused [
	^ self focused not
]

{ #category : #controlling }
BlElementState >> & anAnotherState [
	^ self and: anAnotherState
]

{ #category : #comparing }
BlElementState >> = anotherState [
	^ anotherState class = self class
]

{ #category : #controlling }
BlElementState >> and: anAnotherState [
	^ BlElementConjunctionState new
		left: self;
		right: anAnotherState
]

{ #category : #comparing }
BlElementState >> hash [
	^ self class hash
]

{ #category : #testing }
BlElementState >> matches: aSetOfStates [
	^ aSetOfStates hasState: self
]

{ #category : #controlling }
BlElementState >> not [
	^ BlElementNegationState new state: self
]

{ #category : #enumerating }
BlElementState >> optionalEventHandlerDo: aBlock [
]

{ #category : #enumerating }
BlElementState >> optionalOnAddedTo: anElement [
]

{ #category : #enumerating }
BlElementState >> optionalOnRemovedFrom: anElement [
]

{ #category : #controlling }
BlElementState >> or: anAnotherState [
	^ BlElementDisjunctionState new
		left: self;
		right: anAnotherState
]

{ #category : #accessing }
BlElementState >> priority [
	^ self subclassResponsibility
]

{ #category : #testing }
BlElementState >> shouldPropagateToChildren [
	^ false
]

{ #category : #accessing }
BlElementState >> type [
	"Return an object used to compare two states when adding to the collection of states in order to prevent
	elements from having duplicated states"
	<return: #Object>

	^ self subclassResponsibility
]

{ #category : #controlling }
BlElementState >> | anAnotherState [
	^ self or: anAnotherState
]
