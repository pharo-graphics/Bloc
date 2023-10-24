Class {
	#name : #BlSpaceFrameStylePhase,
	#superclass : #BlSpaceFramePhase,
	#category : 'Bloc-Space - Frame'
}

{ #category : #accessing }
BlSpaceFrameStylePhase >> name [
	<return: #String>
	
	^ 'Style'
]

{ #category : #actions }
BlSpaceFrameStylePhase >> runOn: aSpace [
	aSpace
		dispatchTimeEvent: BlSpaceStyleEndEvent
		during: [ :theSpace | theSpace doStyle ]
]
