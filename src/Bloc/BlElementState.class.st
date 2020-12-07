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

{ #category : #propagation }
BlElementState >> finishedPropagateFrom: aParentElement [
	"The computation of the propagation rules can be expensive, especially if there are
	many children. I am sent right after all #propagatedStateFrom:to: message sends to
	give states a chance to release propagation rule caches"
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

{ #category : #propagation }
BlElementState >> prepareToPropagateFrom: aParentElement [
	"The computation of the propagation rules can be expensive, especially if there are
	many children. I am sent right before all #propagatedStateFrom:to: message sends to
	give states a chance to precompute propagation rules"
]

{ #category : #accessing }
BlElementState >> priority [
	^ self subclassResponsibility
]

{ #category : #propagation }
BlElementState >> propagatedStateFrom: aParentElement to: aChildElement [
	"Return a state that should be propagated from a given parent element to the child instead of me"
	<return: #BlElementState>

	^ self
]

{ #category : #testing }
BlElementState >> shouldOverwriteChildState [
	"Return true if I should overwrite an already existed child's state"
	<return: #Boolean>

	^ false
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
