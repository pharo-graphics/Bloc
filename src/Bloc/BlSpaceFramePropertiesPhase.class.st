Class {
	#name : 'BlSpaceFramePropertiesPhase',
	#superclass : 'BlSpaceFramePhase',
	#category : 'Bloc-Space - Frame',
	#package : 'Bloc',
	#tag : 'Space - Frame'
}

{ #category : 'accessing' }
BlSpaceFramePropertiesPhase >> name [
	<return: #String>
	
	^ 'Properties'
]

{ #category : 'actions' }
BlSpaceFramePropertiesPhase >> runOn: aSpace [
	aSpace
		dispatchTimeEvent: BlSpacePropertiesEndEvent
		during: [ :theSpace | theSpace doComputeProperties ]
]
