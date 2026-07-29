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
BlSpace class >> simulate: anElement during: aBlock [

	| tempSpace topMostElement result |
	anElement isAttachedToSceneGraph
		ifTrue: [ 
			result := aBlock value.
			anElement space ifNotNil: [ :s | s waitPendingWork ] ]
		ifFalse: [
			topMostElement := anElement topMostParent.
			tempSpace := BlSpace new.
			tempSpace root addChild: topMostElement.
			[
				result := aBlock value.
				tempSpace waitPendingWork.
			] ensure: [
				topMostElement removeFromParent ] ].
	^ result
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateClickOn: anElement [
	self
		deprecated: 'Use anElement eventSimulator click instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ self simulate: anElement during: [ anElement eventSimulator click ]
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateClickOn: anElement button: aButton [
	self
		deprecated: 'Use anElement eventSimulator clickButton: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ self simulate: anElement during: [ anElement eventSimulator clickButton: aButton ]
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateClickOutside: anElement [
	self
		deprecated: 'Use anElement eventSimulator clickOutside instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ self simulate: anElement during: [ anElement eventSimulator clickOutside ]
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateDoubleClickOn: anElement [
	self
		deprecated: 'Use anElement eventSimulator doubleClick instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ self simulate: anElement during: [ anElement eventSimulator doubleClick ]
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateDragOn: anElement by: aBlVector [
	self
		deprecated: 'Use anElement eventSimulator dragBy: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ self simulate: anElement during: [ anElement eventSimulator dragBy: aBlVector ]
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateDragOn: anElement byAll: aSequenceOfBlVectors [
	self
		deprecated: 'Use anElement eventSimulator dragByAll: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ self simulate: anElement during: [ anElement eventSimulator dragByAll: aSequenceOfBlVectors ]
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateEvent: anEvent on: anElement [
	self
		deprecated: 'Use anElement eventSimulator event: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ self simulate: anElement during: [ anElement eventSimulator event: anEvent ]
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateEvents: aCollectionOfEvents on: anElement [
	self
		deprecated: 'Use anElement eventSimulator events: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ self simulate: anElement during: [ anElement eventSimulator events: aCollectionOfEvents ]
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateKeyDownOn: anElement key: aKeyboardKey [
	self
		deprecated: 'Use anElement eventSimulator keyDown: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ self simulate: anElement during: [ anElement eventSimulator keyDown: aKeyboardKey ]
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateKeyUpOn: anElement key: aKeyboardKey [
	self
		deprecated: 'Use anElement eventSimulator keyUp: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ self simulate: anElement during: [ anElement eventSimulator keyUp: aKeyboardKey ]
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseDownOn: anElement [
	self
		deprecated: 'Use anElement eventSimulator mouseDown instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ self simulate: anElement during: [ anElement eventSimulator mouseDown ]
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseDownOn: anElement at: aPoint [
	self
		deprecated: 'Use anElement eventSimulator mouseDownAt: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ self simulate: anElement during: [ anElement eventSimulator mouseDownAt: aPoint ]
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveInside: anElement [
	self
		deprecated: 'Use anElement eventSimulator mouseMoveInside instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ self simulate: anElement during: [ anElement eventSimulator mouseMoveInside ]
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveOn: anElement at: aPoint [
	self
		deprecated: 'Use anElement eventSimulator mouseMoveAt: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ self simulate: anElement during: [ anElement eventSimulator mouseMoveAt: aPoint ]
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveOn: anElement from: aFromPoint to: aToPoint [
	self
		deprecated: 'Use anElement eventSimulator mouseMoveFrom:to: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ self simulate: anElement during: [ anElement eventSimulator mouseMoveFrom: aFromPoint to: aToPoint ]
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseMoveOutside: anElement [
	self
		deprecated: 'Use anElement eventSimulator mouseMoveOutside instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ self simulate: anElement during: [ anElement eventSimulator mouseMoveOutside ]
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseUpOn: anElement [
	self
		deprecated: 'Use anElement eventSimulator mouseUp instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ self simulate: anElement during: [ anElement eventSimulator mouseUp ]
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseUpOn: anElement at: aPoint [
	self
		deprecated: 'Use anElement eventSimulator mouseUpAt: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ self simulate: anElement during: [ anElement eventSimulator mouseUpAt: aPoint ]
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateMouseWheelOn: anElement by: aBlVector [
	self
		deprecated: 'Use anElement eventSimulator mouseWheelBy: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ self simulate: anElement during: [ anElement eventSimulator mouseWheelBy: aBlVector ]
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateSecondaryClickOn: anElement [
	self
		deprecated: 'Use anElement eventSimulator secondaryClick instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ self simulate: anElement during: [ anElement eventSimulator secondaryClick ]
]

{ #category : #'*Bloc-Simulation' }
BlSpace class >> simulateTextInput: aString on: aBlElement [
	self
		deprecated: 'Use aBlElement eventSimulator textInput: instead'
		on: '2026-06-26'
		in: 'Bloc'.
	^ self simulate: aBlElement during: [ aBlElement eventSimulator textInput: aString ]
]
