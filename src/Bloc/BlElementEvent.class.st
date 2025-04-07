"
I represent events that happen to a `BlElement`. For example, a change in position or extent.
"
Class {
	#name : #BlElementEvent,
	#superclass : #BlEvent,
	#category : #'Bloc-Events-Type-Element'
}

{ #category : #'api - enable / disable' }
BlElementEvent class >> disableIn: anEventDispatcher [
	self subclassResponsibility
]

{ #category : #'api - enable / disable' }
BlElementEvent class >> enableIn: anEventDispatcher [
	self subclassResponsibility
]

{ #category : #'api - enable / disable' }
BlElementEvent class >> wantedIn: anEventDispatcher [
	self subclassResponsibility
]

{ #category : #testing }
BlElementEvent >> isElementEvent [
	^ true
]
