"
Is sent when element's transformation changes.

Note: transformation may change even if an element has no parent

"
Class {
	#name : #BlElementTransformationChangedEvent,
	#superclass : #BlElementEvent,
	#category : #'Bloc-Events-Type-Element'
}

{ #category : #'api - enable / disable' }
BlElementTransformationChangedEvent class >> enableIn: anEventDispatcher [
	anEventDispatcher enableTransformationChanged
]

{ #category : #'api - enable / disable' }
BlElementTransformationChangedEvent class >> wantedIn: anObject [
	^ anObject wantsTransformationChanged
]

{ #category : #sending }
BlElementTransformationChangedEvent >> sendTo: anObject [
	anObject elementTransformationChangedEvent: self
]
