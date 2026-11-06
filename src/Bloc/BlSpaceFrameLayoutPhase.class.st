Class {
	#name : #BlSpaceFrameLayoutPhase,
	#superclass : #BlSpaceFramePhase,
	#category : #'Bloc-Space - Frame'
}

{ #category : #testing }
BlSpaceFrameLayoutPhase >> isLayoutPhase [
	^ true
]

{ #category : #testing }
BlSpaceFrameLayoutPhase >> isSettledIn: aSpace [
	"Return true if aSpace does not have any pending layout requests, and no block waits for the layouts to be done"

	^ aSpace isLayoutRequested not and: [ aSpace hasLayoutSettledActions not ]
]

{ #category : #accessing }
BlSpaceFrameLayoutPhase >> name [
	^ 'Layout'
]

{ #category : #actions }
BlSpaceFrameLayoutPhase >> runOn: aSpace [

	aSpace
		dispatchTimeEvent: BlSpaceLayoutEndEvent
		during: [ aSpace doLayout ]
]
