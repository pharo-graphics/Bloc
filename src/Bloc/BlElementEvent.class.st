"
I am a root class of all element events that are sent by ==BlElement== as a reaction to various changes, for example position or extent.

See ==BlElementEventExamples== for related examples.
"
Class {
	#name : #BlElementEvent,
	#superclass : #BlEvent,
	#category : #'Bloc-Events-Element'
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
