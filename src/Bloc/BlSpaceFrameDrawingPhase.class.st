Class {
	#name : #BlSpaceFrameDrawingPhase,
	#superclass : #BlSpaceFramePhase,
	#category : #'Bloc-Space - Frame'
}

{ #category : #testing }
BlSpaceFrameDrawingPhase >> isDrawingPhase [
	^ true
]

{ #category : #accessing }
BlSpaceFrameDrawingPhase >> name [
	^ 'Drawing'
]

{ #category : #actions }
BlSpaceFrameDrawingPhase >> runOn: aSpace [

	aSpace
		dispatchTimeEvent: BlSpaceRenderEndEvent
		during: [ aSpace render ]
]
