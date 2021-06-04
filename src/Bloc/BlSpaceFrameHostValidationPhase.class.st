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
	<return: #String>
	
	^ 'Host validation'
]

{ #category : #actions }
BlSpaceFrameHostValidationPhase >> reopenSpace: aSpace [
	| aCloseEventHandler |
	
	aCloseEventHandler := nil.
	aCloseEventHandler := BlEventHandler
		on: BlSpaceClosedEvent
		do: [ :anEvent |
			aSpace removeEventHandler: aCloseEventHandler.
			aSpace host: BlHost pickHost.
			aSpace show ].
	
	aSpace addEventHandler: aCloseEventHandler.
	aSpace close
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
	aSpace hostSpace needsRebuild
		ifFalse: [ ^ self ].
		
	aSpace beDirtyArea.

	aSpace host destroyHostSpaceFor: aSpace.
	aSpace host createHostSpaceFor: aSpace.
	aSpace hostSpace show
]
