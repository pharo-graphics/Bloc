Class {
	#name : #BlEventSimulatorTest,
	#superclass : #TestCase,
	#instVars : [
		'space',
		'element'
	],
	#category : #'Bloc-Tests-Simulation'
}

{ #category : #running }
BlEventSimulatorTest >> setUp [
	super setUp.
	space := BlSpace new.
	element := BlElement new.
	element extent: 100 @ 100.
	space root addChild: element
]

{ #category : #running }
BlEventSimulatorTest >> tearDown [
	space close.
	super tearDown
]

{ #category : #tests }
BlEventSimulatorTest >> testClick [
	| clicked |
	clicked := false.
	element
		addEventHandlerOn: BlClickEvent
		do: [ :event | clicked := true ].
	
	element simulator click.
	
	self assert: clicked
]

{ #category : #tests }
BlEventSimulatorTest >> testDoubleClick [
	| doubleClicked |
	doubleClicked := false.
	element
		addEventHandlerOn: BlDoubleClickEvent
		do: [ :event | doubleClicked := true ].
	
	element simulator doubleClick.
	
	self assert: doubleClicked
]

{ #category : #tests }
BlEventSimulatorTest >> testMouseDownAndUp [
	| downCount upCount simulator |
	downCount := 0.
	upCount := 0.
	element
		addEventHandlerOn: BlMouseDownEvent
		do: [ :event | downCount := downCount + 1 ].
	element
		addEventHandlerOn: BlMouseUpEvent
		do: [ :event | upCount := upCount + 1 ].
	
	simulator := element simulator.
	simulator mouseDown.
	simulator mouseUp.
		
	self assert: downCount equals: 1.
	self assert: upCount equals: 1.
]

{ #category : #tests }
BlEventSimulatorTest >> testMouseMove [
	| movedTo |
	element
		addEventHandlerOn: BlMouseMoveEvent
		do: [ :event | movedTo := event position ].
	
	element simulator mouseMoveAt: 10 @ 20.
	
	self assert: movedTo equals: 10 @ 20.
]

{ #category : #tests }
BlEventSimulatorTest >> testMouseWheel [
	| wheelVector |
	element
		addEventHandlerOn: BlMouseWheelEvent
		do: [ :event | wheelVector := event vector ].
	
	element simulator mouseWheelBy: (BlVector x: 5 y: 10).
	
	self assert: wheelVector equals: (BlVector x: 5 y: 10) asBlocVector.
]

{ #category : #tests }
BlEventSimulatorTest >> testTextInput [
	| textInputText |
	element
		addEventHandlerOn: BlTextInputEvent
		do: [ :event | textInputText := event text ].
	
	element simulator textInput: 'hello'.
	
	self assert: textInputText equals: 'hello'.
]

{ #category : #tests }
BlEventSimulatorTest >> testKeyboardEvents [
	| keyDownKey keyUpKey simulator |
	element
		addEventHandlerOn: BlKeyDownEvent
		do: [ :event | keyDownKey := event key ].
	element
		addEventHandlerOn: BlKeyUpEvent
		do: [ :event | keyUpKey := event key ].
	
	simulator := element simulator.
	simulator keyDown: KeyboardKey escape.
	simulator keyUp: KeyboardKey escape.
		
	self assert: keyDownKey equals: KeyboardKey escape.
	self assert: keyUpKey equals: KeyboardKey escape.
]

{ #category : #tests }
BlEventSimulatorTest >> testVirtualDeviceState [
	| clicked modifierState simulator |
	clicked := false.
	element
		addEventHandlerOn: BlClickEvent
		do: [ :event | 
			clicked := true.
			modifierState := event modifiers copy ].
	
	simulator := element simulator.
	simulator shiftDown.
	self assert: simulator modifiers isShift.
	
	simulator click.
	self assert: clicked.
	self assert: modifierState isShift.
	self assert: modifierState isCtrl not.
	
	simulator shiftUp.
	self assert: simulator modifiers isShift not.
]

{ #category : #tests }
BlEventSimulatorTest >> testVirtualDeviceMouseMoveBy [
	| movedTo simulator |
	element
		addEventHandlerOn: BlMouseMoveEvent
		do: [ :event | movedTo := event position ].
	
	simulator := element simulator.
	"Default starting position should center on the element"
	simulator mouseMoveBy: 10 @ 20.
	
	self assert: movedTo isNotNil.
]

{ #category : #tests }
BlEventSimulatorTest >> testKeyPress [
	| keyDownKey keyUpKey simulator |
	element
		addEventHandlerOn: BlKeyDownEvent
		do: [ :event | keyDownKey := event key ].
	element
		addEventHandlerOn: BlKeyUpEvent
		do: [ :event | keyUpKey := event key ].
	
	simulator := element simulator.
	simulator keyPress: KeyboardKey escape.
		
	self assert: keyDownKey equals: KeyboardKey escape.
	self assert: keyUpKey equals: KeyboardKey escape.
	self deny: (simulator isKeyPressed: KeyboardKey escape)
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
	
	element simulator click.
	
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
	
	element simulator doubleClick.
	
	self assert: doubleClicked
]
