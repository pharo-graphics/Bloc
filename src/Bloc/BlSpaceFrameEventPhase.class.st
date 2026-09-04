Class {
	#name : #BlSpaceFrameEventPhase,
	#superclass : #BlSpaceFramePhase,
	#category : #'Bloc-Space - Frame'
}

{ #category : #testing }
BlSpaceFrameEventPhase >> isEventPhase [
	^ true
]

{ #category : #testing }
BlSpaceFrameEventPhase >> isSettledIn: aSpace [
	"Return true if there are no pending UI events waiting for aSpace"

	^ aSpace hasEvents not
]

{ #category : #accessing }
BlSpaceFrameEventPhase >> name [
	^ 'Event processing'
]

{ #category : #actions }
BlSpaceFrameEventPhase >> runOn: aSpace [

	aSpace
		dispatchTimeEvent: BlSpaceEventsProcessedEvent
		during: [
			"We must update focused element before processing events, otherwise keyboard events, for example, will be handled by the wrong element"
			aSpace doUpdateFocus.

			"Process events enqueued in space and dispatch them to the scene graph"
			aSpace dequeuedEvents do: [ :anEvent |
				"we have to test for existence of the space before handling each event because it is possible that a space is closed due to an event"
				aSpace isOpened ifTrue: [
					aSpace dispatchEvent: anEvent ] ].

			aSpace hostSpaceDo: [ :aHostSpace | aHostSpace generateEvents ].
			aSpace mouseProcessor generateEvents ]
]
