"
I make sure that a host space is valid and re-create it if needed

"
Class {
	#name : #BlSpaceFrameHostValidationPhase,
	#superclass : #BlSpaceFramePhase,
	#category : 'Bloc-Space - Frame'
}

{ #category : #accessing }
BlSpaceFrameHostValidationPhase >> name [
	"Return the string representing the name of the receiver."
	
	^ 'Host validation'
]

{ #category : #actions }
BlSpaceFrameHostValidationPhase >> reopenSpace: aSpace [
	aSpace host: BlHost pickHost
]

{ #category : #actions }
BlSpaceFrameHostValidationPhase >> runOn: aSpace [
	aSpace hasHostSpace
		ifFalse: [ ^ self ].
		
	aSpace host isStillAvailable
		ifTrue: [ self validateHostSpace: aSpace ]
		ifFalse: [ self reopenSpace: aSpace ]
]

{ #category : #actions }
BlSpaceFrameHostValidationPhase >> validateHostSpace: aSpace [

	aSpace hostSpace needsRebuild ifFalse: [ ^ self ].
		
	aSpace invalidateAll.

	aSpace host
		destroyHostSpaceFor: aSpace;
		createHostSpaceFor: aSpace.
	aSpace hostSpace show
]
