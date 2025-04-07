"
Is sent when element is no longer within mouse selection rectangle

"
Class {
	#name : #BlElementSelectionLostEvent,
	#superclass : #BlElementEvent,
	#category : #'Bloc-Events-Type-Element'
}

{ #category : #'api - enable / disable' }
BlElementSelectionLostEvent class >> disableIn: anObject [
	anObject disableSelectionLost
]

{ #category : #'api - enable / disable' }
BlElementSelectionLostEvent class >> enableIn: anObject [
	anObject enableSelectionLost
]

{ #category : #'api - enable / disable' }
BlElementSelectionLostEvent class >> wantedIn: anObject [
	^ anObject wantsSelectionLost
]
