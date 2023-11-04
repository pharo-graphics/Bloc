Class {
	#name : #BlElementScrolledEvent,
	#superclass : #BlElementEvent,
	#instVars : [
		'delta'
	],
	#category : 'Bloc-Events-Type-Element'
}

{ #category : 'instance creation' }
BlElementScrolledEvent class >> delta: aPoint [
	^ self new
		delta: aPoint;
		yourself
]

{ #category : 'api - enable / disable' }
BlElementScrolledEvent class >> disableIn: anObject [
	anObject disableScrolledEvent
]

{ #category : 'api - enable / disable' }
BlElementScrolledEvent class >> enableIn: anObject [
	anObject enableScrolledEvent
]

{ #category : 'api - enable / disable' }
BlElementScrolledEvent class >> wantedIn: anObject [
	^ anObject wantsScrolledEvent
]

{ #category : 'accessing' }
BlElementScrolledEvent >> delta [
	<return: #Point>

	^ delta
]

{ #category : 'accessing' }
BlElementScrolledEvent >> delta: aPoint [
	delta := aPoint
]

{ #category : 'sending' }
BlElementScrolledEvent >> sendTo: anObject [
	anObject elementScrolledEvent: self
]
