"
I am a virtual keyboard to debug key press events

[[[
	BlDevKeyboard new asScalableElement
]]]
"
Class {
	#name : #BlDevKeyboard,
	#superclass : #BlElement,
	#instVars : [
		'keymap'
	],
	#category : #'Bloc-DevTool-Tools'
}

{ #category : #initialization }
BlDevKeyboard >> addButton: anElement key: aKey [
	keymap at: aKey put: anElement.
	self addChild: anElement
]

{ #category : #initialization }
BlDevKeyboard >> initialize [
	super initialize.
	
	self layout: BlFlowLayout new.
	self size: self keyboardWidth @ self keyboardHeight.
	self background: (Color gray alpha: 0.1).
	
	keymap := Dictionary new.
	
	self initializeKeys.
	self initializeEventListeners.
	self requestFocus
]

{ #category : #initialization }
BlDevKeyboard >> initializeBottomRow [
	
	self addButton: (self simpleSmallKey: 'fn') key: BlKeyboardKey function.
	self addButton: (self simpleSmallKey: 'control') key: BlKeyboardKey controlLeft.
	self addButton: (self simpleSmallKey: 'option') key: BlKeyboardKey altLeft.
	self addButton: (self wideSmallKey: 'command' span: 1.2) key: BlKeyboardKey metaLeft.
	self addButton: (self wideSmallKey: '' span: 4.5) key: BlKeyboardKey space.
	self addButton: (self wideSmallKey: 'command' span: 1.2) key: BlKeyboardKey metaRight.
	self addButton: (self simpleSmallKey: 'option') key: BlKeyboardKey altRight.
	
	self addButton: (self simpleSmallKey: 'left') key: BlKeyboardKey arrowLeft.
	self addButton: (self simpleSmallKey: 'up') key: BlKeyboardKey arrowUp.
	self addButton: (self simpleSmallKey: 'right') key: BlKeyboardKey arrowRight.
	self addButton: (self simpleSmallKey: 'down') key: BlKeyboardKey arrowDown.
]

{ #category : #initialization }
BlDevKeyboard >> initializeEventListeners [
	self when: BlKeyDownEvent do: [ :anEvent |
		('down: ', anEvent key asString) logCr.
		StringSignal emit: ('down: ', anEvent key asString).

		keymap
			at: anEvent key
			ifPresent: [ :aButton | aButton background: (Color veryVeryLightGray) ]
			ifAbsent: [
				self inform: 'Unknown: ', anEvent key asString.
				NonInteractiveTranscript stdout show: ('Unknown: ', anEvent key asString); cr ] ].
		
	self when: BlKeyUpEvent do: [ :anEvent |
		('up ', anEvent key asString) logCr.
		StringSignal emit: ('up: ', anEvent key asString).
		keymap
			at: anEvent key
			ifPresent: [ :aButton | aButton background: (Color white) ] ].
]

{ #category : #initialization }
BlDevKeyboard >> initializeFirstRow [
	| theKeys |
	
	self addButton: (self wideKey: 'tab' span: 1.45) key: BlKeyboardKey tab.
	
	theKeys := #(q w e r t y u i o p) collect: [ :each | BlKeyboardKey perform: each ].
	theKeys do: [ :eachKey | self addButton: (self simpleKey: eachKey name) key: eachKey ].
	
	self addButton: (self simpleKey: '[') key: BlKeyboardKey leftBracket.
	self addButton: (self simpleKey: ']') key: BlKeyboardKey rightBracket.
	self addButton: (self simpleKey: '\') key: BlKeyboardKey backslash.
]

{ #category : #initialization }
BlDevKeyboard >> initializeKeys [
	self initializeTopRow.
	self initializeFirstRow.
	self initializeSecondRow.
	self initializeThirdRow.
	self initializeBottomRow
]

{ #category : #initialization }
BlDevKeyboard >> initializeSecondRow [
	| theKeys |
	
	self addButton: (self wideKey: 'capslock' span: 1.8) key: BlKeyboardKey capsLock.

	theKeys := #(a s d f g h j k l) collect: [ :each | BlKeyboardKey perform: each ].
	theKeys do: [ :eachKey | self addButton: (self simpleKey: eachKey name) key: eachKey ].
	
	self addButton: (self simpleKey: ';') key: BlKeyboardKey semicolon.
	self addButton: (self simpleKey: '''') key: BlKeyboardKey quote.
	self addButton: (self wideKey: 'return' span: 1.8) key: BlKeyboardKey return.
]

{ #category : #initialization }
BlDevKeyboard >> initializeThirdRow [
	| theKeys |
	
	self addButton: (self wideKey: 'shift' span: 2.42) key: BlKeyboardKey shiftLeft.
	
	theKeys := #(z x c v b n m) collect: [ :each | BlKeyboardKey perform: each ].
	theKeys do: [ :eachKey | self addButton: (self simpleKey: eachKey name) key: eachKey ].
	
	self addButton: (self simpleKey: ',') key: BlKeyboardKey comma.
	self addButton: (self simpleKey: '.') key: BlKeyboardKey period.
	self addButton: (self simpleKey: '/') key: BlKeyboardKey slash.
	
	self addButton: (self wideKey: 'shift' span: 2.42) key: BlKeyboardKey shiftRight.
]

{ #category : #initialization }
BlDevKeyboard >> initializeTopRow [
	| theKeys |
	
	self addButton: (self simpleKey: '`') key: BlKeyboardKey grave.
	
	theKeys := #(one two three four five six seven eight nine zero) collect: [ :each | BlKeyboardKey perform: each ].
	theKeys do: [ :eachKey | self addButton: (self simpleKey: eachKey name) key: eachKey ].
	
	self addButton: (self simpleKey: '-') key: BlKeyboardKey minus.
	self addButton: (self simpleKey: '=') key: BlKeyboardKey equal.
	self addButton: (self wideKey: 'delete' span: 1.45) key: BlKeyboardKey backspace.
]

{ #category : #geometry }
BlDevKeyboard >> keyboardHeight [
	^ (5 * self rowHeight) + ((5 * 2 + 1) * self spacing)
]

{ #category : #geometry }
BlDevKeyboard >> keyboardWidth [
	^ self rowWidth
]

{ #category : #'instance creation' }
BlDevKeyboard >> newButton: anExtent [
	^ BlElement new
		size: anExtent;
		geometry: (BlRectangle cornerRadius: 4);
		border: (BlBorder paint: (Color gray alpha: 0.2) width: 1);
		layout: (BlFrameLayout new);
		effect: (BlDropShadowEffect color: (Color black alpha: 0.1) width: 2 offset: 0@1);
		margin: (BlInsets all: self spacing);
		background: (Color white)
]

{ #category : #geometry }
BlDevKeyboard >> rowHeight [
	^ 35
]

{ #category : #geometry }
BlDevKeyboard >> rowWidth [
	^ (13 * self simpleKeyWidth) + (self wideWidth: 1.5) + ((14 * 2) * self spacing)
]

{ #category : #'instance creation' }
BlDevKeyboard >> simpleKey: aString [
	| button label |

	button := self newButton: self simpleKeyExtent.

	label := BlTextElement new.
	label tightMeasurement.
	label clipChildren: false.
	label text: (aString asRopedText fontSize: 16).
	label constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	button addChild: label.
	^ button
]

{ #category : #geometry }
BlDevKeyboard >> simpleKeyExtent [
	^ self simpleKeyWidth @ self rowHeight
]

{ #category : #geometry }
BlDevKeyboard >> simpleKeyWidth [
	^ self rowHeight * 1.2
]

{ #category : #'instance creation' }
BlDevKeyboard >> simpleSmallKey: aString [
	| button label |
	
	button := self newButton: self simpleKeyExtent.

	label := BlTextElement new.
	label tightMeasurement.
	label clipChildren: false.
	label text: (aString asRopedText fontSize: 11).
	label constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	button addChild: label.
	^ button
]

{ #category : #geometry }
BlDevKeyboard >> spacing [
	^ 5
]

{ #category : #'instance creation' }
BlDevKeyboard >> wideKey: aString span: aNumber [
	| button label |
	
	button := self newButton: (self wideWidth: aNumber) @ self rowHeight.

	label := BlTextElement new.
	label tightMeasurement.
	label clipChildren: false.
	label text: (aString asRopedText fontSize: 13).
	label constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	button addChild: label.
	^ button
]

{ #category : #'instance creation' }
BlDevKeyboard >> wideSmallKey: aString span: aNumber [
	| button label |

	button := self newButton: (self wideWidth: aNumber) @ self rowHeight.

	label := BlTextElement new.
	label tightMeasurement.
	label clipChildren: false.
	label text: (aString asRopedText fontSize: 11).
	label constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	button addChild: label.
	^ button
]

{ #category : #geometry }
BlDevKeyboard >> wideWidth: aNumber [
	^ ((self simpleKeyWidth * aNumber) + self spacing)
]
