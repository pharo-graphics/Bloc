Class {
	#name : 'BlSpaceFrameIdlePhase',
	#superclass : 'BlSpaceFramePhase',
	#category : 'Bloc-Space - Frame',
	#package : 'Bloc',
	#tag : 'Space - Frame'
}

{ #category : 'testing' }
BlSpaceFrameIdlePhase >> isIdlePhase [
	^ true
]

{ #category : 'accessing' }
BlSpaceFrameIdlePhase >> name [
	^ 'Idle'
]

{ #category : 'actions' }
BlSpaceFrameIdlePhase >> runOn: aSpace [
	
]
