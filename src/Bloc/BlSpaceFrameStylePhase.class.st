Class {
	#name : #BlSpaceFrameStylePhase,
	#superclass : #BlSpaceFramePhase,
	#category : 'Bloc-Space - Frame'
}

{ #category : #accessing }
BlSpaceFrameStylePhase >> name [
	"Return the string representing the name of the receiver."
	
	^ 'Style'
]

{ #category : #actions }
BlSpaceFrameStylePhase >> runOn: aSpace [
	aSpace
		dispatchTimeEvent: BlSpaceStyleEndEvent
		during: [ :theSpace | theSpace doStyle ]
]
