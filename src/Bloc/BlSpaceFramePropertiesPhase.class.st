Class {
	#name : #BlSpaceFramePropertiesPhase,
	#superclass : #BlSpaceFramePhase,
	#category : 'Bloc-Space - Frame'
}

{ #category : #accessing }
BlSpaceFramePropertiesPhase >> name [
	"Return the string representing the name of the receiver."
	
	^ 'Properties'
]

{ #category : #actions }
BlSpaceFramePropertiesPhase >> runOn: aSpace [
	aSpace
		dispatchTimeEvent: BlSpacePropertiesEndEvent
		during: [ :theSpace | theSpace doComputeProperties ]
]
