Class {
	#name : #BlSpaceFrameSkinInstallationPhase,
	#superclass : #BlSpaceFramePhase,
	#category : #'Bloc-Space - Frame'
}

{ #category : #accessing }
BlSpaceFrameSkinInstallationPhase >> name [
	<return: #String>
	
	^ 'Skin installation'
]

{ #category : #actions }
BlSpaceFrameSkinInstallationPhase >> runOn: aSpace [

	aSpace root checkSkinInstallation
]
