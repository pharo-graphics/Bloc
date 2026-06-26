Extension { #name : #BlSpace }

{ #category : #'*Bloc-Simulation' }
BlSpace class >> locationInside: anElement [
	self
		deprecated: 'Use (BlEventSimulator forTarget: anElement) locationInside instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) locationInside
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> locationOutside: anElement [
	self
		deprecated: 'Use (BlEventSimulator forTarget: anElement) locationOutside instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) locationOutside
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
		deprecated: 'Use (BlEventSimulator forTarget: anElement) simulateClick instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) simulateClick
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateClickOn: anElement button: aButton [
	self
		deprecated: 'Use (BlEventSimulator forTarget: anElement) simulateClickButton: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) simulateClickButton: aButton
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateClickOutside: anElement [
	self
		deprecated: 'Use (BlEventSimulator forTarget: anElement) simulateClickOutside instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) simulateClickOutside
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateDoubleClickOn: anElement [
	self
		deprecated: 'Use (BlEventSimulator forTarget: anElement) simulateDoubleClick instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) simulateDoubleClick
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateDragOn: anElement by: aBlVector [
	self
		deprecated: 'Use (BlEventSimulator forTarget: anElement) simulateDragBy: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) simulateDragBy: aBlVector
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateDragOn: anElement byAll: aSequenceOfBlVectors [
	self
		deprecated: 'Use (BlEventSimulator forTarget: anElement) simulateDragByAll: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) simulateDragByAll: aSequenceOfBlVectors
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateEvent: anEvent on: anElement [
	self
		deprecated: 'Use (BlEventSimulator forTarget: anElement) simulateEvent: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) simulateEvent: anEvent
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateEvents: aCollectionOfEvents on: anElement [
	self
		deprecated: 'Use (BlEventSimulator forTarget: anElement) simulateEvents: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) simulateEvents: aCollectionOfEvents
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateKeyDownOn: anElement key: aKeyboardKey [
	self
		deprecated: 'Use (BlEventSimulator forTarget: anElement) simulateKeyDown: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) simulateKeyDown: aKeyboardKey
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateKeyUpOn: anElement key: aKeyboardKey [
	self
		deprecated: 'Use (BlEventSimulator forTarget: anElement) simulateKeyUp: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) simulateKeyUp: aKeyboardKey
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseDownOn: anElement [
	self
		deprecated: 'Use (BlEventSimulator forTarget: anElement) simulateMouseDown instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) simulateMouseDown
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseDownOn: anElement at: aPoint [
	self
		deprecated: 'Use (BlEventSimulator forTarget: anElement) simulateMouseDownAt: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) simulateMouseDownAt: aPoint
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveInside: anElement [
	self
		deprecated: 'Use (BlEventSimulator forTarget: anElement) simulateMouseMoveInside instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) simulateMouseMoveInside
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveOn: anElement at: aPoint [
	self
		deprecated: 'Use (BlEventSimulator forTarget: anElement) simulateMouseMoveAt: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) simulateMouseMoveAt: aPoint
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveOn: anElement from: aFromPoint to: aToPoint [
	self
		deprecated: 'Use (BlEventSimulator forTarget: anElement) simulateMouseMoveFrom:to: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) simulateMouseMoveFrom: aFromPoint to: aToPoint
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveOutside: anElement [
	self
		deprecated: 'Use (BlEventSimulator forTarget: anElement) simulateMouseMoveOutside instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) simulateMouseMoveOutside
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseUpOn: anElement [
	self
		deprecated: 'Use (BlEventSimulator forTarget: anElement) simulateMouseUp instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) simulateMouseUp
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseUpOn: anElement at: aPoint [
	self
		deprecated: 'Use (BlEventSimulator forTarget: anElement) simulateMouseUpAt: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) simulateMouseUpAt: aPoint
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseWheelOn: anElement by: aBlVector [
	self
		deprecated: 'Use (BlEventSimulator forTarget: anElement) simulateMouseWheelBy: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) simulateMouseWheelBy: aBlVector
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateSecondaryClickOn: anElement [
	self
		deprecated: 'Use (BlEventSimulator forTarget: anElement) simulateSecondaryClick instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: anElement) simulateSecondaryClick
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateTextInput: aString on: aBlElement [
	self
		deprecated: 'Use (BlEventSimulator forTarget: aBlElement) simulateTextInput: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forTarget: aBlElement) simulateTextInput: aString
]
