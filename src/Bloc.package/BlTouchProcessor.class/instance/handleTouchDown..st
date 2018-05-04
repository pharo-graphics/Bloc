api - touch down
handleTouchDown: aTouchDownEvent
	| aTargetElement |

	"First we need to register a pressed pointer"
	
	self
		assert: [ (self pressedPointers includes: aTouchDownEvent pointerId) not ]
		description: [ 'Pointer is already pressed' ].
	
	self pressedPointers add: aTouchDownEvent pointerId.

	aTargetElement := self processPicking: aTouchDownEvent.

	aTouchDownEvent target: aTargetElement.
	aTouchDownEvent pointerIndex: self pressedPointers size.

	self fireEvent: aTouchDownEvent.

	"now we can update the cursor from the target"
	self updateCursorFrom: aTargetElement.

	"store last mouse down event"
	previousTouchDownEvent := aTouchDownEvent