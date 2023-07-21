Class {
	#name : #BlSpaceFrameSkinInitializationPhase,
	#superclass : #BlSpaceFramePhase,
	#category : #'Bloc-Space - Frame'
}

{ #category : #accessing }
BlSpaceFrameSkinInitializationPhase >> name [
	<return: #String>
	
	^ 'Skin initialization'
]

{ #category : #actions }
BlSpaceFrameSkinInitializationPhase >> runOn: aSpace [

	aSpace root checkSkinInitialization
]
