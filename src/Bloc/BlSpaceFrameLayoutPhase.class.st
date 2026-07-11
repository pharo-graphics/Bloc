Class {
	#name : #BlSpaceFrameLayoutPhase,
	#superclass : #BlSpaceFramePhase,
	#category : #'Bloc-Space - Frame'
}

{ #category : #testing }
BlSpaceFrameLayoutPhase >> isLayoutPhase [
	^ true
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
