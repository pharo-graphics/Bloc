Class {
	#name : #BlGestureProcessor,
	#superclass : #BlBaseEventProcessor,
	#category : #'Bloc-Space - Events'
}

{ #category : #'api - gestures' }
BlGestureProcessor >> handleGesture: aGestureEvent [
	| aTargetElement |

	aTargetElement := self processPicking: aGestureEvent.
	aGestureEvent target: aTargetElement.
	self processGesture: aGestureEvent
]

{ #category : #'api - gestures' }
BlGestureProcessor >> processGesture: aGestureEvent [
	self fireEvent: aGestureEvent.

	"now we can update the cursor from the target"
	self updateCursorFrom: aGestureEvent target
]

{ #category : #'event processing' }
BlGestureProcessor >> processPicking: aTouchEvent [
	<return: #BlElement>
	| aTargetElement |

	aTargetElement := self space root findMouseEventTargetAt: aTouchEvent position.
	"we have to ensure that aTarget is not nil"
	aTargetElement ifNil: [ aTargetElement := self space root ].
	^ aTargetElement
]

{ #category : #'event processing' }
BlGestureProcessor >> updateCursorFrom: aTarget [
	| t |
	t := aTarget.
	[ t mouseCursor isNil and: [ t parent isNotNil ] ] whileTrue: [ t := t parent ].
	self space currentCursor = t mouseCursor
		ifTrue: [ ^ self ].
	self space currentCursor: t mouseCursor
]
