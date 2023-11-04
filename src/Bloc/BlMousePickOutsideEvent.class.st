Class {
	#name : 'BlMousePickOutsideEvent',
	#superclass : 'BlElementEvent',
	#instVars : [
		'originalEvent',
		'lastMouseDownEvent'
	],
	#category : 'Bloc-Events-Type-Element'
}

{ #category : 'api - enable / disable' }
BlMousePickOutsideEvent class >> disableIn: anEventDispatcher [

	anEventDispatcher disableMousePickedOutside 
]

{ #category : 'api - enable / disable' }
BlMousePickOutsideEvent class >> enableIn: anEventDispatcher [

	anEventDispatcher enableMousePickedOutside 
]

{ #category : 'api - enable / disable' }
BlMousePickOutsideEvent class >> wantedIn: anEventDispatcher [

	^ anEventDispatcher wantsMousePickedOutside
]

{ #category : 'converting' }
BlMousePickOutsideEvent >> asMouseOutsideEvent [

	^ self 
]

{ #category : 'accessing' }
BlMousePickOutsideEvent >> lastMouseDownEvent [

	^ lastMouseDownEvent
]

{ #category : 'accessing' }
BlMousePickOutsideEvent >> lastMouseDownEvent: aBlEvent [

	lastMouseDownEvent := aBlEvent
]

{ #category : 'accessing' }
BlMousePickOutsideEvent >> originalEvent [

	^ originalEvent
]

{ #category : 'accessing' }
BlMousePickOutsideEvent >> originalEvent: aBlEvent [

	aBlEvent consumed: true.
	originalEvent := aBlEvent
]

{ #category : 'sending' }
BlMousePickOutsideEvent >> sendTo: anObject [

	anObject mousePickOutsideEvent: self
]
