"
Is sent when element's position within its parent changes.

Note: position may change even if an element has no parent

"
Class {
	#name : 'BlElementPositionChangedEvent',
	#superclass : 'BlElementEvent',
	#category : 'Bloc-Events-Type-Element',
	#package : 'Bloc',
	#tag : 'Events-Type-Element'
}

{ #category : 'api - enable / disable' }
BlElementPositionChangedEvent class >> disableIn: anObject [
	anObject disablePositionChanged
]

{ #category : 'api - enable / disable' }
BlElementPositionChangedEvent class >> enableIn: anObject [
	anObject enablePositionChanged
]

{ #category : 'api - enable / disable' }
BlElementPositionChangedEvent class >> wantedIn: anObject [
	^ anObject wantsPositionChanged
]

{ #category : 'sending' }
BlElementPositionChangedEvent >> sendTo: anObject [
	anObject elementPositionChangedEvent: self
]
