"
I represent a frame phase.

Each phase knows about its start time and send a corresponding event once the phase is completed.

"
Class {
	#name : 'BlSpaceFramePhase',
	#superclass : 'Object',
	#category : 'Bloc-Space - Frame',
	#package : 'Bloc',
	#tag : 'Space - Frame'
}

{ #category : 'testing' }
BlSpaceFramePhase >> isDrawingPhase [
	^ false
]

{ #category : 'testing' }
BlSpaceFramePhase >> isEventPhase [
	^ false
]

{ #category : 'testing' }
BlSpaceFramePhase >> isIdlePhase [
	^ false
]

{ #category : 'testing' }
BlSpaceFramePhase >> isLayoutPhase [
	^ false
]

{ #category : 'testing' }
BlSpaceFramePhase >> isTaskPhase [
	^ false
]

{ #category : 'accessing' }
BlSpaceFramePhase >> name [
	"Return the string representing the name of the receiver."
	
	^ self subclassResponsibility
]

{ #category : 'actions' }
BlSpaceFramePhase >> runOn: aSpace [
	self subclassResponsibility
]
