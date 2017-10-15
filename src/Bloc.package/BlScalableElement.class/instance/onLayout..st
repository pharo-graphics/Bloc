layout
onLayout: aBounds
	| oldExtent newScaleFactor translateDelta |

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
	translateDelta := (self measuredExtent - oldExtent) / 2.0.
	
	self contentElement transform
		scaleBy: (BlVector x: scaleFactor y: scaleFactor z: 1);
		translateBy: (BlVector x: translateDelta x y: translateDelta y z: 0);
		apply.