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

	aSpace validateHostSpaceDrawing
]
