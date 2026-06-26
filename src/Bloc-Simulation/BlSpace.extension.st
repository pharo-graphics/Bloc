Extension { #name : #BlSpace }

{ #category : #'*Bloc-Simulation' }
BlSpace class >> locationInside: anElement [
	self
		deprecated: 'Use BlEventSimulator class >> #locationInside: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator locationInside: anElement
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> locationOutside: anElement [
	self
		deprecated: 'Use BlEventSimulator class >> #locationOutside: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator locationOutside: anElement
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
		deprecated: 'Use BlEventSimulator class >> #simulateClickOn: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator simulateClickOn: anElement
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateClickOn: anElement button: aButton [
	self
		deprecated: 'Use BlEventSimulator class >> #simulateClickOn:button: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator simulateClickOn: anElement button: aButton
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateClickOutside: anElement [
	self
		deprecated: 'Use BlEventSimulator class >> #simulateClickOutside: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator simulateClickOutside: anElement
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateDoubleClickOn: anElement [
	self
		deprecated: 'Use BlEventSimulator class >> #simulateDoubleClickOn: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator simulateDoubleClickOn: anElement
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateDragOn: anElement by: aBlVector [
	self
		deprecated: 'Use BlEventSimulator class >> #simulateDragOn:by: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator simulateDragOn: anElement by: aBlVector
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateDragOn: anElement byAll: aSequenceOfBlVectors [
	self
		deprecated: 'Use BlEventSimulator class >> #simulateDragOn:byAll: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator simulateDragOn: anElement byAll: aSequenceOfBlVectors
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateEvent: anEvent on: anElement [
	self
		deprecated: 'Use BlEventSimulator class >> #simulateEvent:on: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator simulateEvent: anEvent on: anElement
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateEvents: aCollectionOfEvents on: anElement [
	self
		deprecated: 'Use BlEventSimulator class >> #simulateEvents:on: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator simulateEvents: aCollectionOfEvents on: anElement
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateKeyDownOn: anElement key: aKeyboardKey [
	self
		deprecated: 'Use BlEventSimulator class >> #simulateKeyDownOn:key: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator simulateKeyDownOn: anElement key: aKeyboardKey
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateKeyUpOn: anElement key: aKeyboardKey [
	self
		deprecated: 'Use BlEventSimulator class >> #simulateKeyUpOn:key: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator simulateKeyUpOn: anElement key: aKeyboardKey
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseDownOn: anElement [
	self
		deprecated: 'Use BlEventSimulator class >> #simulateMouseDownOn: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator simulateMouseDownOn: anElement
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseDownOn: anElement at: aPoint [
	self
		deprecated: 'Use BlEventSimulator class >> #simulateMouseDownOn:at: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator simulateMouseDownOn: anElement at: aPoint
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveInside: anElement [
	self
		deprecated: 'Use BlEventSimulator class >> #simulateMouseMoveInside: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator simulateMouseMoveInside: anElement
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveOn: anElement at: aPoint [
	self
		deprecated: 'Use BlEventSimulator class >> #simulateMouseMoveOn:at: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator simulateMouseMoveOn: anElement at: aPoint
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveOn: anElement from: aFromPoint to: aToPoint [
	self
		deprecated: 'Use BlEventSimulator class >> #simulateMouseMoveOn:from:to: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator simulateMouseMoveOn: anElement from: aFromPoint to: aToPoint
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveOutside: anElement [
	self
		deprecated: 'Use BlEventSimulator class >> #simulateMouseMoveOutside: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator simulateMouseMoveOutside: anElement
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseUpOn: anElement [
	self
		deprecated: 'Use BlEventSimulator class >> #simulateMouseUpOn: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator simulateMouseUpOn: anElement
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseUpOn: anElement at: aPoint [
	self
		deprecated: 'Use BlEventSimulator class >> #simulateMouseUpOn:at: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator simulateMouseUpOn: anElement at: aPoint
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseWheelOn: anElement by: aBlVector [
	self
		deprecated: 'Use BlEventSimulator class >> #simulateMouseWheelOn:by: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator simulateMouseWheelOn: anElement by: aBlVector
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateSecondaryClickOn: anElement [
	self
		deprecated: 'Use BlEventSimulator class >> #simulateSecondaryClickOn: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator simulateSecondaryClickOn: anElement
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateTextInput: aString on: aBlElement [
	self
		deprecated: 'Use BlEventSimulator class >> #simulateTextInput:on: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ BlEventSimulator simulateTextInput: aString on: aBlElement
]
