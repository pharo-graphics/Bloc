api - touch move
handleTouchMove: aTouchEvent
	| aTargetElement |
	
	aTargetElement := self processPicking: aTouchEvent.
	self
		assert: [ aTargetElement isAttachedToSceneGraph ]
		description: [ 'Target element must be attached to the scene graph' ].
	
	aTouchEvent target: aTargetElement.
	aTouchEvent pointerIndex: (self pressedPointers indexOf: aTouchEvent pointerId).

	self processTouchMove: aTouchEvent