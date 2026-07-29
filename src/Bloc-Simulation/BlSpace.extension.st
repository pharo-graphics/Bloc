Extension { #name : #BlSpace }

{ #category : #'*Bloc-Simulation' }
BlSpace class >> locationInside: anElement [
	self
		deprecated: 'Use anElement eventSimulator locationInside instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ anElement eventSimulator locationInside
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> locationOutside: anElement [
	self
		deprecated: 'Use anElement eventSimulator locationOutside instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ anElement eventSimulator locationOutside
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> pulseUntilEmptyTaskQueue: aSpace timeout: aDuration [
	self
		deprecated: 'Use space waitPendingWorkForDuration: aDuration instead'
		on: '2026-07-14'
		in: 'Bloc'.
	^ aSpace waitPendingWorkForDuration: aDuration
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> pulseUntilSpaceOpenedAndEmptyTaskQueue: aSpace timeout: aDuration [

	self
		deprecated: 'Use aSpace waitPendingWorkForDuration: aDuration instead'
		on: '2026-07-14'
		in: 'Bloc'.

	^ aSpace waitPendingWorkForDuration: aDuration
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateClickOn: anElement [
	| result |
	self
		deprecated: 'Use anElement eventSimulator click instead'
		on: '2026-06-26'
		in: 'Bloc'.
	result := anElement eventSimulator click.
	anElement space ifNotNil: [ :s | s waitPendingWork ].
	^ result
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateClickOn: anElement button: aButton [
	| result |
	self
		deprecated: 'Use anElement eventSimulator clickButton: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	result := anElement eventSimulator clickButton: aButton.
	anElement space ifNotNil: [ :s | s waitPendingWork ].
	^ result
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateClickOutside: anElement [
	| result |
	self
		deprecated: 'Use anElement eventSimulator clickOutside instead'
		on: '2026-06-26'
		in: 'Bloc'.
	result := anElement eventSimulator clickOutside.
	anElement space ifNotNil: [ :s | s waitPendingWork ].
	^ result
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateDoubleClickOn: anElement [
	| result |
	self
		deprecated: 'Use anElement eventSimulator doubleClick instead'
		on: '2026-06-26'
		in: 'Bloc'.
	result := anElement eventSimulator doubleClick.
	anElement space ifNotNil: [ :s | s waitPendingWork ].
	^ result
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateDragOn: anElement by: aBlVector [
	| result |
	self
		deprecated: 'Use anElement eventSimulator dragBy: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	result := anElement eventSimulator dragBy: aBlVector.
	anElement space ifNotNil: [ :s | s waitPendingWork ].
	^ result
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateDragOn: anElement byAll: aSequenceOfBlVectors [
	| result |
	self
		deprecated: 'Use anElement eventSimulator dragByAll: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	result := anElement eventSimulator dragByAll: aSequenceOfBlVectors.
	anElement space ifNotNil: [ :s | s waitPendingWork ].
	^ result
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateEvent: anEvent on: anElement [
	| result |
	self
		deprecated: 'Use anElement eventSimulator event: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	result := anElement eventSimulator event: anEvent.
	anElement space ifNotNil: [ :s | s waitPendingWork ].
	^ result
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateEvents: aCollectionOfEvents on: anElement [
	| result |
	self
		deprecated: 'Use anElement eventSimulator events: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	result := anElement eventSimulator events: aCollectionOfEvents.
	anElement space ifNotNil: [ :s | s waitPendingWork ].
	^ result
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateKeyDownOn: anElement key: aKeyboardKey [
	| result |
	self
		deprecated: 'Use anElement eventSimulator keyDown: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	result := anElement eventSimulator keyDown: aKeyboardKey.
	anElement space ifNotNil: [ :s | s waitPendingWork ].
	^ result
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateKeyUpOn: anElement key: aKeyboardKey [
	| result |
	self
		deprecated: 'Use anElement eventSimulator keyUp: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	result := anElement eventSimulator keyUp: aKeyboardKey.
	anElement space ifNotNil: [ :s | s waitPendingWork ].
	^ result
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseDownOn: anElement [
	| result |
	self
		deprecated: 'Use anElement eventSimulator mouseDown instead'
		on: '2026-06-26'
		in: 'Bloc'.
	result := anElement eventSimulator mouseDown.
	anElement space ifNotNil: [ :s | s waitPendingWork ].
	^ result
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseDownOn: anElement at: aPoint [
	| result |
	self
		deprecated: 'Use anElement eventSimulator mouseDownAt: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	result := anElement eventSimulator mouseDownAt: aPoint.
	anElement space ifNotNil: [ :s | s waitPendingWork ].
	^ result
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveInside: anElement [
	| result |
	self
		deprecated: 'Use anElement eventSimulator mouseMoveInside instead'
		on: '2026-06-26'
		in: 'Bloc'.
	result := anElement eventSimulator mouseMoveInside.
	anElement space ifNotNil: [ :s | s waitPendingWork ].
	^ result
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveOn: anElement at: aPoint [
	| result |
	self
		deprecated: 'Use anElement eventSimulator mouseMoveAt: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	result := anElement eventSimulator mouseMoveAt: aPoint.
	anElement space ifNotNil: [ :s | s waitPendingWork ].
	^ result
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveOn: anElement from: aFromPoint to: aToPoint [
	| result |
	self
		deprecated: 'Use anElement eventSimulator mouseMoveFrom:to: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	result := anElement eventSimulator mouseMoveFrom: aFromPoint to: aToPoint.
	anElement space ifNotNil: [ :s | s waitPendingWork ].
	^ result
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveOutside: anElement [
	| result |
	self
		deprecated: 'Use anElement eventSimulator mouseMoveOutside instead'
		on: '2026-06-26'
		in: 'Bloc'.
	result := anElement eventSimulator mouseMoveOutside.
	anElement space ifNotNil: [ :s | s waitPendingWork ].
	^ result
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseUpOn: anElement [
	| result |
	self
		deprecated: 'Use anElement eventSimulator mouseUp instead'
		on: '2026-06-26'
		in: 'Bloc'.
	result := anElement eventSimulator mouseUp.
	anElement space ifNotNil: [ :s | s waitPendingWork ].
	^ result
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseUpOn: anElement at: aPoint [
	| result |
	self
		deprecated: 'Use anElement eventSimulator mouseUpAt: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	result := anElement eventSimulator mouseUpAt: aPoint.
	anElement space ifNotNil: [ :s | s waitPendingWork ].
	^ result
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseWheelOn: anElement by: aBlVector [
	| result |
	self
		deprecated: 'Use anElement eventSimulator mouseWheelBy: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	result := anElement eventSimulator mouseWheelBy: aBlVector.
	anElement space ifNotNil: [ :s | s waitPendingWork ].
	^ result
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateSecondaryClickOn: anElement [
	| result |
	self
		deprecated: 'Use anElement eventSimulator secondaryClick instead'
		on: '2026-06-26'
		in: 'Bloc'.
	result := anElement eventSimulator secondaryClick.
	anElement space ifNotNil: [ :s | s waitPendingWork ].
	^ result
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateTextInput: aString on: aBlElement [
	| result |
	self
		deprecated: 'Use aBlElement eventSimulator textInput: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	result := aBlElement eventSimulator textInput: aString.
	aBlElement space ifNotNil: [ :s | s waitPendingWork ].
	^ result
]
