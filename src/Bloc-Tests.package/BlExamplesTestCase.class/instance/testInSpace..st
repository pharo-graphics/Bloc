tests
testInSpace: anElement
	| aSpace aTopMostElement semaphore timeout |
	
	aTopMostElement := anElement topMostParent.
	aTopMostElement isAttachedToSceneGraph
		ifTrue: [ ^ self ].

	semaphore := Semaphore new.

	aSpace := BlTestAutoClosingSpace new.
	aSpace root addChild: aTopMostElement.
	
	aSpace
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ semaphore signal ].
	aSpace show.

	timeout := semaphore waitTimeoutMSecs: 1000.
	timeout ifTrue: [ aSpace close ].

	aTopMostElement removeFromParent