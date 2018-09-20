Class {
	#name : #BlSpaceFrameEventPhase,
	#superclass : #BlSpaceFramePhase,
	#category : #'Bloc-Space-Frame'
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
	"We must update focused element before processing events, otherwise keyboard events,
	for example, will be handled by the wrong element"
	aSpace doUpdateFocus.

	aSpace
		dispatchTimeEvent: BlSpaceEventEndEvent
		during: [ aSpace hasHostSpace ifTrue: [ aSpace processEvents ] ]
]
