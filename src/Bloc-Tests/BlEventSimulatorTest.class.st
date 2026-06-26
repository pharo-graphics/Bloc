Class {
	#name : #BlEventSimulatorTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Simulation'
}

{ #category : #tests }
BlEventSimulatorTest >> testClick [
	| element clicked |
	clicked := false.
	element := BlElement new.
	element size: 100 @ 100.
	element addEventHandlerOn: BlClickEvent do: [ :event | clicked := true ].
	
	(BlEventSimulator forTarget: element) simulateClick.
	
	self assert: clicked
]

{ #category : #tests }
BlEventSimulatorTest >> testDoubleClick [
	| element doubleClicked |
	doubleClicked := false.
	element := BlElement new.
	element size: 100 @ 100.
	element addEventHandlerOn: BlDoubleClickEvent do: [ :event | doubleClicked := true ].
	
	(BlEventSimulator forTarget: element) simulateDoubleClick.
	
	self assert: doubleClicked
]

{ #category : #tests }
BlEventSimulatorTest >> testMouseDownAndUp [
	| element downCount upCount simulator |
	downCount := 0.
	upCount := 0.
	element := BlElement new.
	element size: 100 @ 100.
	element addEventHandlerOn: BlMouseDownEvent do: [ :event | downCount := downCount + 1 ].
	element addEventHandlerOn: BlMouseUpEvent do: [ :event | upCount := upCount + 1 ].
	
	simulator := BlEventSimulator forTarget: element.
	simulator simulateMouseDown.
	simulator simulateMouseUp.
		
	self assert: downCount equals: 1.
	self assert: upCount equals: 1.
]

{ #category : #tests }
BlEventSimulatorTest >> testMouseMove [
	| element movedTo |
	element := BlElement new.
	element size: 100 @ 100.
	element addEventHandlerOn: BlMouseMoveEvent do: [ :event | movedTo := event position ].
	
	(BlEventSimulator forTarget: element) simulateMouseMoveAt: 10 @ 20.
	
	self assert: movedTo equals: 10 @ 20.
]

{ #category : #tests }
BlEventSimulatorTest >> testMouseWheel [
	| element wheelVector |
	element := BlElement new.
	element size: 100 @ 100.
	element addEventHandlerOn: BlMouseWheelEvent do: [ :event | wheelVector := event vector ].
	
	(BlEventSimulator forTarget: element) simulateMouseWheelBy: (BlVector x: 5 y: 10).
	
	self assert: wheelVector equals: (BlVector x: 5 y: 10) asBlocVector.
]

{ #category : #tests }
BlEventSimulatorTest >> testTextInput [
	| element textInputText |
	element := BlElement new.
	element size: 100 @ 100.
	element addEventHandlerOn: BlTextInputEvent do: [ :event | textInputText := event text ].
	
	(BlEventSimulator forTarget: element) simulateTextInput: 'hello'.
	
	self assert: textInputText equals: 'hello'.
]

{ #category : #tests }
BlEventSimulatorTest >> testKeyboardEvents [
	| element keyDownKey keyUpKey simulator |
	element := BlElement new.
	element size: 100 @ 100.
	element addEventHandlerOn: BlKeyDownEvent do: [ :event | keyDownKey := event key ].
	element addEventHandlerOn: BlKeyUpEvent do: [ :event | keyUpKey := event key ].
	
	simulator := BlEventSimulator forTarget: element.
	simulator simulateKeyDown: KeyboardKey escape.
	simulator simulateKeyUp: KeyboardKey escape.
		
	self assert: keyDownKey equals: KeyboardKey escape.
	self assert: keyUpKey equals: KeyboardKey escape.
]

{ #category : #tests }
BlEventSimulatorTest >> testVirtualDeviceState [
	| element clicked modifierState simulator |
	clicked := false.
	element := BlElement new.
	element size: 100 @ 100.
	element addEventHandlerOn: BlClickEvent do: [ :event | 
		clicked := true.
		modifierState := event modifiers copy ].
	
	simulator := BlEventSimulator forTarget: element.
	simulator shiftDown.
	self assert: simulator modifiers isShift.
	
	simulator simulateClick.
	self assert: clicked.
	self assert: modifierState isShift.
	self assert: modifierState isCtrl not.
	
	simulator shiftUp.
	self assert: simulator modifiers isShift not.
]

{ #category : #tests }
BlEventSimulatorTest >> testVirtualDeviceMouseMoveBy [
	| element movedTo simulator |
	element := BlElement new.
	element size: 100 @ 100.
	element addEventHandlerOn: BlMouseMoveEvent do: [ :event | movedTo := event position ].
	
	simulator := BlEventSimulator forTarget: element.
	"Default starting position should center on the element"
	simulator mouseMoveBy: 10 @ 20.
	
	self assert: movedTo isNotNil.
]

{ #category : #tests }
BlEventSimulatorTest >> testKeyPress [
	| element keyDownKey keyUpKey simulator |
	element := BlElement new.
	element size: 100 @ 100.
	element addEventHandlerOn: BlKeyDownEvent do: [ :event | keyDownKey := event key ].
	element addEventHandlerOn: BlKeyUpEvent do: [ :event | keyUpKey := event key ].
	
	simulator := BlEventSimulator forTarget: element.
	simulator keyPress: KeyboardKey escape.
		
	self assert: keyDownKey equals: KeyboardKey escape.
	self assert: keyUpKey equals: KeyboardKey escape.
	self deny: (simulator isKeyPressed: KeyboardKey escape)
]

{ #category : #tests }
BlEventSimulatorTest >> testVirtualDeviceClick [
	| element clicked count |
	clicked := false.
	count := 0.
	element := BlElement new.
	element size: 100 @ 100.
	element addEventHandlerOn: BlClickEvent do: [ :event | 
		clicked := true.
		count := count + 1 ].
	
	(BlEventSimulator forTarget: element) click.
	
	self assert: clicked.
	self assert: count equals: 1
]

{ #category : #tests }
BlEventSimulatorTest >> testVirtualDeviceDoubleClick [
	| element doubleClicked |
	doubleClicked := false.
	element := BlElement new.
	element size: 100 @ 100.
	element addEventHandlerOn: BlDoubleClickEvent do: [ :event | doubleClicked := true ].
	
	(BlEventSimulator forTarget: element) doubleClick.
	
	self assert: doubleClicked
]
