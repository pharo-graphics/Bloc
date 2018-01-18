tests
testInSpace: anElement
	| aSpace aTopMostElement semaphore timeout error |
	
	aTopMostElement := anElement topMostParent.
	aTopMostElement isAttachedToSceneGraph
		ifTrue: [ ^ self ].

	semaphore := Semaphore new.

	aSpace := BlTestAutoClosingSpace new.
	aSpace root addChild: aTopMostElement.

	aSpace
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ semaphore signal ].
	aSpace
		addEventHandlerOn: BlSpaceErrorEvent
		do: [ :anEvent |
			error := anEvent error.
			semaphore signal ].
	aSpace show.

	timeout := semaphore waitTimeoutMSecs: 2000.
	aTopMostElement removeFromParent.
	
	timeout ifTrue: [
		aSpace close.
		self classForTestResult signalErrorWith: anElement gtDisplayString ].
	
	error
		ifNotNil: [ self classForTestResult signalErrorWith: error messageText ]