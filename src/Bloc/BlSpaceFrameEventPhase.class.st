Class {
	#name : #BlSpaceFrameEventPhase,
	#superclass : #BlSpaceFramePhase,
	#category : #'Bloc-Space - Frame'
}

{ #category : #testing }
BlSpaceFrameEventPhase >> isEventPhase [
	^ true
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

			"Process events enqueued by host space and dispatch them to the scene graph"
			aSpace hostSpaceDo: [ :aHostSpace |
				aHostSpace fetchedEventsDo: [ :anEvent |
					"we have to test for existance of the host space before handling each event because it is possible that a space is closed due to an event"
					aSpace hostSpaceDo: [
						aSpace dispatchEvent: anEvent ] ] ].

			aSpace hostSpaceDo: [ :aHostSpace | aHostSpace generateEvents ].
			aSpace mouseProcessor generateEvents ]
]
