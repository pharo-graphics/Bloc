"
Is sent when element's extent in local coordinates changes.

"
Class {
	#name : 'BlElementExtentChangedEvent',
	#superclass : 'BlElementEvent',
	#category : 'Bloc-Events-Type-Element'
}

{ #category : 'api - enable / disable' }
BlElementExtentChangedEvent class >> enableIn: anObject [
	anObject enableExtentChanged
]

{ #category : 'api - enable / disable' }
BlElementExtentChangedEvent class >> wantedIn: anObject [
	^ anObject wantsExtentChanged
]

{ #category : 'sending' }
BlElementExtentChangedEvent >> sendTo: anObject [
	anObject elementExtentChangedEvent: self
]
