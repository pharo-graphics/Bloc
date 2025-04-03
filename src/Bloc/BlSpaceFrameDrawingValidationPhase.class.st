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

	aSpace hostSpace needsRebuild ifTrue: [ ^ self ].

	aSpace hostSpace hasResized ifFalse: [ ^ self ].

	aSpace invalidateAll.

	aSpace hostSpace initializeRenderer
]
