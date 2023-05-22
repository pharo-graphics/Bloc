"
I represent an intermediate pulling step, that begun with a `BlPullStartEvent` and will finish with a `BlPullEndEvent`.

I know the initial position (in space) where the pull started, and the current position where the pull dragging is located.
"
Class {
	#name : #BlPullEvent,
	#superclass : #BlEvent,
	#instVars : [
		'initialDragPosition',
		'currentDragPosition'
	],
	#category : #'Bloc-PullAndSlide-Events'
}

{ #category : #accessing }
BlPullEvent >> currentPosition [

	^ currentDragPosition
]

{ #category : #accessing }
BlPullEvent >> currentPosition: aPoint [

	currentDragPosition := aPoint
]

{ #category : #accessing }
BlPullEvent >> deltaFromInitialPosition [

	^ currentDragPosition - initialDragPosition
]

{ #category : #accessing }
BlPullEvent >> initialPosition [

	^ initialDragPosition
]

{ #category : #accessing }
BlPullEvent >> initialPosition: aPoint [

	initialDragPosition := aPoint
]
