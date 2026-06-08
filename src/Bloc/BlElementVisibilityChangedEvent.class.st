Class {
	#name : #BlElementVisibilityChangedEvent,
	#superclass : #BlElementEvent,
	#category : #'Bloc-Events-Type-Element'
}

{ #category : #'api - enable / disable' }
BlElementVisibilityChangedEvent class >> disableIn: anEventDispatcher [

	anEventDispatcher disableVisibilityChanged
]

{ #category : #'api - enable / disable' }
BlElementVisibilityChangedEvent class >> enableIn: anEventDispatcher [

	anEventDispatcher enableVisibilityChanged
]

{ #category : #'api - enable / disable' }
BlElementVisibilityChangedEvent class >> wantedIn: anEventDispatcher [

	^ anEventDispatcher wantsVisibilityChanged 
]

{ #category : #sending }
BlElementVisibilityChangedEvent >> sendTo: anObject [

	anObject elementVisibilityChangedEvent: self
]
