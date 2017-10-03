layout
onLayout: aBounds
	| oldExtent newScaleFactor |

	super onLayout: aBounds.
	
	self hasContentElement
		ifFalse: [ ^ self ].
	

	oldExtent := self contentElement measuredExtent.

	newScaleFactor := (oldExtent x isZero or: oldExtent y isZero)
		ifTrue: [ 1 ]
		ifFalse: [ ((self measuredExtent / oldExtent) min max: 0.01) ].

	((scaleFactor - newScaleFactor) abs < 0.01 asPoint)
		ifTrue: [ ^ self ].

	scaleFactor := newScaleFactor.	
	self contentElement scaleTo: newScaleFactor asPoint asFloatPoint.
	