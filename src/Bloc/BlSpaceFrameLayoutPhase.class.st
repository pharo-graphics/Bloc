Class {
	#name : 'BlSpaceFrameLayoutPhase',
	#superclass : 'BlSpaceFramePhase',
	#category : 'Bloc-Space - Frame',
	#package : 'Bloc',
	#tag : 'Space - Frame'
}

{ #category : 'testing' }
BlSpaceFrameLayoutPhase >> isLayoutPhase [
	^ true
]

{ #category : 'accessing' }
BlSpaceFrameLayoutPhase >> name [
	^ 'Layout'
]

{ #category : 'actions' }
BlSpaceFrameLayoutPhase >> runOn: aSpace [
	aSpace
		dispatchTimeEvent: BlSpaceLayoutEndEvent
		during: [ :theSpace | theSpace doLayout ].
]
