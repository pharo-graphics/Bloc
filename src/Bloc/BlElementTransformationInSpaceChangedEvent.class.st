"
Is sent when elemen't transformation in space coordinates changes.

Transformation in space may change even if element's transformation is still the same. It can happen when any of its parents has a new transformation.

"
Class {
	#name : 'BlElementTransformationInSpaceChangedEvent',
	#superclass : 'BlElementEvent',
	#package : 'Bloc',
	#tag : 'Events-Type-Element'
}

{ #category : 'api - enable / disable' }
BlElementTransformationInSpaceChangedEvent class >> disableIn: anEventDispatcher [

	anEventDispatcher disableTransformationInSpaceChanged
]

{ #category : 'api - enable / disable' }
BlElementTransformationInSpaceChangedEvent class >> enableIn: anEventDispatcher [
	anEventDispatcher enableTransformationInSpaceChanged
]

{ #category : 'api - enable / disable' }
BlElementTransformationInSpaceChangedEvent class >> wantedIn: anEventDispatcher [
	^ anEventDispatcher wantsTransformationInSpaceChanged
]

{ #category : 'sending' }
BlElementTransformationInSpaceChangedEvent >> sendTo: anObject [
	anObject elementTransformationInSpaceChangedEvent: self
]
