Extension { #name : #BlSpace }

{ #category : #'*Bloc-Simulation' }
BlSpace class >> locationInside: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) locationInside instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) locationInside
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> locationOutside: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) locationOutside instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) locationOutside
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> pulseUntilEmptyTaskQueue: aSpace timeout: aDuration [
	self
		deprecated: 'Use (BlSpaceSimulator forSpace: aSpace) timeout: aDuration; pulseUntilEmptyTaskQueue instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlSpaceSimulator forSpace: aSpace)
		timeout: aDuration;
		pulseUntilEmptyTaskQueue
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> pulseUntilSpaceOpenedAndEmptyTaskQueue: aSpace timeout: aDuration [
	self
		deprecated: 'Use (BlSpaceSimulator forSpace: aSpace) timeout: aDuration; pulseUntilSpaceOpenedAndEmptyTaskQueue instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlSpaceSimulator forSpace: aSpace)
		timeout: aDuration;
		pulseUntilSpaceOpenedAndEmptyTaskQueue
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateClickOn: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) simulateClick instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) simulateClick
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateClickOn: anElement button: aButton [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) simulateClickButton: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) simulateClickButton: aButton
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateClickOutside: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) simulateClickOutside instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) simulateClickOutside
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateDoubleClickOn: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) simulateDoubleClick instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) simulateDoubleClick
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateDragOn: anElement by: aBlVector [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) simulateDragBy: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) simulateDragBy: aBlVector
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateDragOn: anElement byAll: aSequenceOfBlVectors [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) simulateDragByAll: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) simulateDragByAll: aSequenceOfBlVectors
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateEvent: anEvent on: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) simulateEvent: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) simulateEvent: anEvent
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateEvents: aCollectionOfEvents on: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) simulateEvents: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) simulateEvents: aCollectionOfEvents
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateKeyDownOn: anElement key: aKeyboardKey [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) simulateKeyDown: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) simulateKeyDown: aKeyboardKey
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateKeyUpOn: anElement key: aKeyboardKey [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) simulateKeyUp: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) simulateKeyUp: aKeyboardKey
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseDownOn: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) simulateMouseDown instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) simulateMouseDown
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseDownOn: anElement at: aPoint [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) simulateMouseDownAt: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) simulateMouseDownAt: aPoint
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveInside: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) simulateMouseMoveInside instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) simulateMouseMoveInside
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveOn: anElement at: aPoint [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) simulateMouseMoveAt: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) simulateMouseMoveAt: aPoint
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveOn: anElement from: aFromPoint to: aToPoint [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) simulateMouseMoveFrom:to: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) simulateMouseMoveFrom: aFromPoint to: aToPoint
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveOutside: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) simulateMouseMoveOutside instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) simulateMouseMoveOutside
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseUpOn: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) simulateMouseUp instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) simulateMouseUp
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseUpOn: anElement at: aPoint [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) simulateMouseUpAt: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) simulateMouseUpAt: aPoint
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseWheelOn: anElement by: aBlVector [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) simulateMouseWheelBy: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) simulateMouseWheelBy: aBlVector
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateSecondaryClickOn: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) simulateSecondaryClick instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) simulateSecondaryClick
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateTextInput: aString on: aBlElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: aBlElement) simulateTextInput: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: aBlElement) simulateTextInput: aString
]
