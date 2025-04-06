Class {
	#name : #BlSpaceFrameDrawingValidationPhase,
	#superclass : #BlSpaceFramePhase,
	#category : #'Bloc-Space - Frame'
}

{ #category : #accessing }
BlSpaceFrameDrawingValidationPhase >> name [
	^ 'Drawing validation'
]

{ #category : #actions }
BlSpaceFrameDrawingValidationPhase >> runOn: aSpace [

	aSpace hasHostSpace ifFalse: [ ^ self ].
	aSpace hostSpace isValid ifFalse: [ ^ self ].
	aSpace hostSpace hasResized ifFalse: [ ^ self ].

	aSpace invalidateAll.

	aSpace hostSpace initializeRenderer
]
