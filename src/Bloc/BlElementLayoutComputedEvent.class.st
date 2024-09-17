Class {
	#name : #BlElementLayoutComputedEvent,
	#superclass : #BlElementEvent,
	#category : #'Bloc-Events-Type-Element'
}

{ #category : #'api - enable / disable' }
BlElementLayoutComputedEvent class >> disableIn: anObject [
	anObject disableLayoutComputed
]

{ #category : #'api - enable / disable' }
BlElementLayoutComputedEvent class >> enableIn: anObject [
	anObject enableLayoutComputed
]

{ #category : #'api - enable / disable' }
BlElementLayoutComputedEvent class >> wantedIn: anObject [
	^ anObject wantsLayoutComputed
]
