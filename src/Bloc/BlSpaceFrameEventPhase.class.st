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
		during: [ :theSpace |
			"We must update focused element before processing events, otherwise keyboard events,
			for example, will be handled by the wrong element"
			aSpace doUpdateFocus.

			theSpace hostSpaceDo: [ 
				"Process events enqueued by host space and dispatch them to the scene graph"

				theSpace eventRecorder onPulse.

				theSpace hostSpaceDo: [ :aHostSpace |
					aHostSpace fetchedEventsDo: [ :anEvent |
					"we have to test for existance of the host space before handling each event because
					it is possible that a space is closed due to an event"
					
					theSpace hostSpaceDo: [
						theSpace eventRecorder record: anEvent.
						theSpace eventDispatcher dispatchEvent: anEvent ] ] ].
				
				theSpace hostSpaceDo: [ :aHostSpace | aHostSpace generateEvents ] ].
			theSpace mouseProcessor generateEvents ]
]
