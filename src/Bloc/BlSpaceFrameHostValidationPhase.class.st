"
I make sure that a host space is valid and re-create it if needed
"
Class {
	#name : #BlSpaceFrameHostValidationPhase,
	#superclass : #BlSpaceFramePhase,
	#category : #'Bloc-Space-Frame'
}

{ #category : #accessing }
BlSpaceFrameHostValidationPhase >> name [
	<return: #String>
	
	^ 'Host validation'
]

{ #category : #actions }
BlSpaceFrameHostValidationPhase >> runOn: aSpace [
	aSpace hasHostSpace
		ifFalse: [ ^ self ].

	aSpace hostSpace needsRebuild
		ifFalse: [ ^ self ].

	"aSpace host createHostSpaceFor: aSpace.
	aSpace hostSpace show"
]
