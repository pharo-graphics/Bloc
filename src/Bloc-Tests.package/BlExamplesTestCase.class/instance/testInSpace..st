tests
testInSpace: anElement
	| aSpace aTopMostElement |
	
	aTopMostElement := anElement topMostElement.
	aTopMostElement isAttachedToSceneGraph
		ifTrue: [ ^ self ].
	
	aSpace := BlSpace new.
	aSpace root addChild: aTopMostElement.
	
	10 timesRepeat: [ aSpace pulse ].
	
	aTopMostElement removeFromParent