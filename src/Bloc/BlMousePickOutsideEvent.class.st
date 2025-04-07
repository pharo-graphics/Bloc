Class {
	#name : #BlMousePickOutsideEvent,
	#superclass : #BlElementEvent,
	#instVars : [
		'originalEvent',
		'lastMouseDownEvent'
	],
	#category : #'Bloc-Events-Type-Element'
}

{ #category : #'api - enable / disable' }
BlMousePickOutsideEvent class >> disableIn: anEventDispatcher [

	anEventDispatcher disableMousePickedOutside 
]

{ #category : #'api - enable / disable' }
BlMousePickOutsideEvent class >> enableIn: anEventDispatcher [

	anEventDispatcher enableMousePickedOutside 
]

{ #category : #testing }
BlMousePickOutsideEvent class >> isDeprecated [ 

	^ true
]

{ #category : #'api - enable / disable' }
BlMousePickOutsideEvent class >> wantedIn: anEventDispatcher [

	^ anEventDispatcher wantsMousePickedOutside
]

{ #category : #accessing }
BlMousePickOutsideEvent >> lastMouseDownEvent [

	^ lastMouseDownEvent
]

{ #category : #accessing }
BlMousePickOutsideEvent >> lastMouseDownEvent: aBlEvent [

	lastMouseDownEvent := aBlEvent
]

{ #category : #accessing }
BlMousePickOutsideEvent >> originalEvent [

	^ originalEvent
]

{ #category : #accessing }
BlMousePickOutsideEvent >> originalEvent: aBlEvent [

	aBlEvent consume.
	originalEvent := aBlEvent
]
