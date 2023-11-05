"
Is sent when elemen't position in space coordinates changes.

Position in space may change even if element's #position is still the same. It can happen when any of its parents moves.

"
Class {
	#name : 'BlElementPositionInSpaceChangedEvent',
	#superclass : 'BlElementEvent',
	#category : 'Bloc-Events-Type-Element'
}

{ #category : 'api - enable / disable' }
BlElementPositionInSpaceChangedEvent class >> disableIn: anObject [
	anObject disablePositionInSpaceChanged
]

{ #category : 'api - enable / disable' }
BlElementPositionInSpaceChangedEvent class >> enableIn: anObject [
	anObject enablePositionInSpaceChanged
]

{ #category : 'api - enable / disable' }
BlElementPositionInSpaceChangedEvent class >> wantedIn: anObject [
	^ anObject wantsPositionInSpaceChanged
]

{ #category : 'sending' }
BlElementPositionInSpaceChangedEvent >> sendTo: anObject [
	anObject elementPositionInSpaceChangedEvent: self
]
