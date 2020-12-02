Class {
	#name : #BlElementState,
	#superclass : #Object,
	#category : #'Bloc-Basic-State'
}

{ #category : #'instance creation' }
BlElementState class >> collapsed [
	^ self expanded not
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
	^ BrConjunctionState new
		left: self;
		right: anAnotherState
]

{ #category : #comparing }
BlElementState >> hash [
	^ self class hash
]

{ #category : #testing }
BlElementState >> matches: aSetOfStates [
	^ aSetOfStates includes: self
]

{ #category : #controlling }
BlElementState >> not [
	^ BrNegationState new state: self
]

{ #category : #enumerating }
BlElementState >> optionalEventHandlerDo: aBlock [
]

{ #category : #controlling }
BlElementState >> or: anAnotherState [
	^ BrDisjunctionState new
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

{ #category : #controlling }
BlElementState >> | anAnotherState [
	^ self or: anAnotherState
]
