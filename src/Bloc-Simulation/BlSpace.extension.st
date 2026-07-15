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
BlSpace class >> simulateClickOn: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) click instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) click
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateClickOn: anElement button: aButton [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) clickButton: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) clickButton: aButton
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateClickOutside: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) clickOutside instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) clickOutside
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateDoubleClickOn: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) doubleClick instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) doubleClick
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateDragOn: anElement by: aBlVector [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) dragBy: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) dragBy: aBlVector
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateDragOn: anElement byAll: aSequenceOfBlVectors [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) dragByAll: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) dragByAll: aSequenceOfBlVectors
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateEvent: anEvent on: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) event: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) event: anEvent
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateEvents: aCollectionOfEvents on: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) events: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) events: aCollectionOfEvents
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateKeyDownOn: anElement key: aKeyboardKey [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) keyDown: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) keyDown: aKeyboardKey
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateKeyUpOn: anElement key: aKeyboardKey [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) keyUp: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) keyUp: aKeyboardKey
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseDownOn: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) mouseDown instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) mouseDown
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseDownOn: anElement at: aPoint [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) mouseDownAt: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) mouseDownAt: aPoint
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveInside: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) mouseMoveInside instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) mouseMoveInside
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveOn: anElement at: aPoint [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) mouseMoveAt: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) mouseMoveAt: aPoint
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveOn: anElement from: aFromPoint to: aToPoint [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) mouseMoveFrom:to: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) mouseMoveFrom: aFromPoint to: aToPoint
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveOutside: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) mouseMoveOutside instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) mouseMoveOutside
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseUpOn: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) mouseUp instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) mouseUp
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseUpOn: anElement at: aPoint [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) mouseUpAt: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) mouseUpAt: aPoint
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseWheelOn: anElement by: aBlVector [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) mouseWheelBy: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) mouseWheelBy: aBlVector
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateSecondaryClickOn: anElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: anElement) secondaryClick instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: anElement) secondaryClick
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateTextInput: aString on: aBlElement [
	self
		deprecated: 'Use (BlEventSimulator forElement: aBlElement) textInput: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ (BlEventSimulator forElement: aBlElement) textInput: aString
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> pulseUntilEmptyTaskQueue: aSpace timeout: aDuration [
	self
		deprecated: 'Use space host waitEmptyTaskQueueFor: space timeout: aDuration instead'
		on: '2026-07-14'
		in: 'Bloc'.
	^ aSpace host waitEmptyTaskQueueFor: aSpace timeout: aDuration
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> pulseUntilSpaceOpenedAndEmptyTaskQueue: aSpace timeout: aDuration [
	self
		deprecated: 'Use space host waitShownAndEmptyTaskQueueFor: space timeout: aDuration instead'
		on: '2026-07-14'
		in: 'Bloc'.
	^ aSpace host waitShownAndEmptyTaskQueueFor: aSpace timeout: aDuration
]


