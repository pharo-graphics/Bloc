Class {
	#name : #BlEventSimulatorTest,
	#superclass : #BlParameterizedHostTest,
	#instVars : [
		'space',
		'element'
	],
	#category : #'Bloc-Tests-Simulation'
}

{ #category : #running }
BlEventSimulatorTest >> setUp [
	super setUp.
	space := self newTestingSpace.
	element := BlElement new.
	element extent: 100 @ 100.
	element focusability: BlFocusability block.
	space root addChild: element.
	space settle
]

{ #category : #tests }
BlEventSimulatorTest >> testClick [
	| clicked |
	clicked := false.
	element
		addEventHandlerOn: BlClickEvent
		do: [ :event | clicked := true ].
	
	element eventSimulator click.
	
	self assert: clicked
]

{ #category : #tests }
BlEventSimulatorTest >> testDoubleClick [
	| doubleClicked |
	doubleClicked := false.
	element
		addEventHandlerOn: BlDoubleClickEvent
		do: [ :event | doubleClicked := true ].
	
	element eventSimulator doubleClick.
	
	self assert: doubleClicked
]

{ #category : #tests }
BlEventSimulatorTest >> testKeyPress [
	| keyDownKey keyUpKey eventSimulator |
	element requestFocus.
	element
		addEventHandlerOn: BlKeyDownEvent
		do: [ :event | keyDownKey := event key ].
	element
		addEventHandlerOn: BlKeyUpEvent
		do: [ :event | keyUpKey := event key ].
	
	eventSimulator := element eventSimulator.
	eventSimulator keyPress: KeyboardKey escape.
		
	self assert: keyDownKey equals: KeyboardKey escape.
	self assert: keyUpKey equals: KeyboardKey escape.
	self deny: (eventSimulator isKeyPressed: KeyboardKey escape)
]

{ #category : #tests }
BlEventSimulatorTest >> testKeyboardEvents [
	| keyDownKey keyUpKey eventSimulator |
	element requestFocus.
	element
		addEventHandlerOn: BlKeyDownEvent
		do: [ :event | keyDownKey := event key ].
	element
		addEventHandlerOn: BlKeyUpEvent
		do: [ :event | keyUpKey := event key ].
	
	eventSimulator := element eventSimulator.
	eventSimulator keyDown: KeyboardKey escape.
	eventSimulator keyUp: KeyboardKey escape.
		
	self assert: keyDownKey equals: KeyboardKey escape.
	self assert: keyUpKey equals: KeyboardKey escape.
]

{ #category : #tests }
BlEventSimulatorTest >> testMouseDownAndUp [
	| downCount upCount eventSimulator |
	downCount := 0.
	upCount := 0.
	element
		addEventHandlerOn: BlMouseDownEvent
		do: [ :event | downCount := downCount + 1 ].
	element
		addEventHandlerOn: BlMouseUpEvent
		do: [ :event | upCount := upCount + 1 ].
	
	eventSimulator := element eventSimulator.
	eventSimulator mouseDown.
	eventSimulator mouseUp.
		
	self assert: downCount equals: 1.
	self assert: upCount equals: 1.
]

{ #category : #tests }
BlEventSimulatorTest >> testMouseMove [
	| movedTo |
	element
		addEventHandlerOn: BlMouseMoveEvent
		do: [ :event | movedTo := event position ].
	
	element eventSimulator mouseMoveAt: 10 @ 20.
	
	self assert: movedTo equals: 10 @ 20.
]

{ #category : #tests }
BlEventSimulatorTest >> testMouseWheel [

	| wheelVector |
	element
		addEventHandlerOn: BlMouseWheelEvent
		do: [ :event | wheelVector := event vector ].
	
	element eventSimulator mouseWheelBy: (BlVector x: 5 y: 10).
	
	self assert: wheelVector equals: (BlVector x: 5 y: 10) asBlocVector
]

{ #category : #tests }
BlEventSimulatorTest >> testPositionInsideAndOutside [
	| simulator inside outside |
	simulator := element eventSimulator.
	inside := simulator positionInside.
	self assert: inside equals: 50 @ 50.

	outside := simulator positionOutside.
	self assert: (element bounds inSpace bounds containsPoint: outside) not
]

{ #category : #tests }
BlEventSimulatorTest >> testSimulateFromPulseProcessRaisesError [

	| errorRaised |
	errorRaised := false.
	space defer: [
		[ element eventSimulator click ]
			on: Error
			do: [ :err | errorRaised := true ] ].
	space settle.
	self assert: errorRaised
]

{ #category : #tests }
BlEventSimulatorTest >> testTextInput [
	| textInputText |
	element requestFocus.
	element
		addEventHandlerOn: BlTextInputEvent
		do: [ :event | textInputText := event text ].
	
	element eventSimulator textInput: 'hello'.
	
	self assert: textInputText equals: 'hello'.
]

{ #category : #tests }
BlEventSimulatorTest >> testVirtualDeviceClick [
	| clicked count |
	clicked := false.
	count := 0.
	element
		addEventHandlerOn: BlClickEvent
		do: [ :event | 
			clicked := true.
			count := count + 1 ].
	
	element eventSimulator click.
	
	self assert: clicked.
	self assert: count equals: 1
]

{ #category : #tests }
BlEventSimulatorTest >> testVirtualDeviceDoubleClick [
	| doubleClicked |
	doubleClicked := false.
	element
		addEventHandlerOn: BlDoubleClickEvent
		do: [ :event | doubleClicked := true ].
	
	element eventSimulator doubleClick.
	
	self assert: doubleClicked
]

{ #category : #tests }
BlEventSimulatorTest >> testVirtualDeviceMouseMoveBy [
	| movedTo eventSimulator |
	element
		addEventHandlerOn: BlMouseMoveEvent
		do: [ :event | movedTo := event position ].
	
	eventSimulator := element eventSimulator.
	"Default starting position should center on the element"
	eventSimulator mouseMoveBy: 10 @ 20.
	
	self assert: movedTo isNotNil.
]

{ #category : #tests }
BlEventSimulatorTest >> testVirtualDeviceState [
	| clicked modifierState eventSimulator |
	clicked := false.
	element
		addEventHandlerOn: BlClickEvent
		do: [ :event | 
			clicked := true.
			modifierState := event modifiers copy ].
	
	eventSimulator := element eventSimulator.
	eventSimulator shiftDown.
	self assert: eventSimulator modifiers isShift.
	
	eventSimulator click.
	self assert: clicked.
	self assert: modifierState isShift.
	self assert: modifierState isCtrl not.
	
	eventSimulator shiftUp.
	self assert: eventSimulator modifiers isShift not.
]
