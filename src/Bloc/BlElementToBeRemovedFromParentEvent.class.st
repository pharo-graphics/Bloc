Class {
	#name : #BlElementToBeRemovedFromParentEvent,
	#superclass : #BlElementEvent,
	#category : #'Bloc-Events-Type-Element'
}

{ #category : #'api - enable / disable' }
BlElementToBeRemovedFromParentEvent class >> disableIn: anEventDispatcher [
	
]

{ #category : #'api - enable / disable' }
BlElementToBeRemovedFromParentEvent class >> enableIn: anEventDispatcher [

]

{ #category : #'api - enable / disable' }
BlElementToBeRemovedFromParentEvent class >> wantedIn: anEventDispatcher [
	
]

{ #category : #sending }
BlElementToBeRemovedFromParentEvent >> sendTo: anObject [

	anObject elementToBeRemovedFromParentEvent: self
]
