"
I make sure that a host space is valid and re-create it if needed

"
Class {
	#name : #BlSpaceFrameHostValidationPhase,
	#superclass : #BlSpaceFramePhase,
	#category : #'Bloc-Space - Frame'
}

{ #category : #accessing }
BlSpaceFrameHostValidationPhase >> name [
	"Return the string representing the name of the receiver."
	
	^ 'Host validation'
]

{ #category : #actions }
BlSpaceFrameHostValidationPhase >> runOn: aSpace [

	aSpace hasHostSpace ifFalse: [ ^ self ].
	aSpace hostSpace isValid ifTrue: [ ^ self ].

	aSpace
		invalidateAll;
		tearDownHostSpace;
		setUpHostSpace.

	aSpace hostSpace open
]
