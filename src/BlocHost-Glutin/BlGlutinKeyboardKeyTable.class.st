Class {
	#name : #BlGlutinKeyboardKeyTable,
	#superclass : #BlKeyboardKeyTable,
	#instVars : [
		'virtualKeyTable'
	],
	#classInstVars : [
		'default'
	],
	#category : #'BlocHost-Glutin-Host'
}

{ #category : #cleanup }
BlGlutinKeyboardKeyTable class >> cleanUp [
	<script: 'self cleanUp'>
	super cleanUp.
	
	default := nil
]

{ #category : #cleanup }
BlGlutinKeyboardKeyTable class >> default [
	^ default ifNil: [ default := self new ]
]

{ #category : #initialization }
BlGlutinKeyboardKeyTable >> initialize [
	super initialize.

	self initializeVirtualKeyTable
]

{ #category : #initialization }
BlGlutinKeyboardKeyTable >> initializeVirtualKeyTable [
	self
		initialize: (virtualKeyTable := Dictionary new)
		with: #(
			"special"
			Return Return
			Tab Tab
			Space Space
			Delete Delete
			Back Backspace
			Escape Escape
			16r039 CapsLock
			16r3F Function
			
			"modifiers"
			LShift ShiftLeft
			RShift ShiftRight
			LAlt AltLeft
			RAlt AltRight
			LControl ControlLeft
			RControl ControlRight
			LWin MetaLeft
			RWin MetaRight
			
			"sound"
			VolumeUp VolumeUp
			VolumeDown VolumeDown
			Mute Mute
			PlayPause Pause "!!"
			
			"functions"
			F1 F1
			F2 F2
			F3 F3
			F4 F4
			F5 F5
			F6 F6
			F7 F7
			F8 F8
			F9 F9
			F10 F10
			F11 F11
			F12 F12
			
			"navigation"
			16r075 Help
			Snapshot PrintScreen "!!"
			Scroll ScrollLock "!!"
			Insert Insert "!!"
			Home Home
			PageUp PageUp
			End End
			PageDown PageDown
			Left ArrowLeft
			Right ArrowRight
			Down ArrowDown
			Up ArrowUp
			
			"letters"
			A A
			B B
			C C
			D D
			E E
			F F
			G G
			H H
			I I
			J J
			K K
			L L
			M M
			N N
			O O
			P P
			Q Q
			R R
			S S
			T T
			U U
			V V
			W W
			X X
			Y Y
			Z Z

			"digits"
			Key0 Zero
			Key1 One
			Key2 Two
			Key3 Three
			Key4 Four
			Key5 Five
			Key6 Six
			Key7 Seven
			Key8 Eight
			Key9 Nine

			"symbols"
			Minus Minus
			Equals Equal
			LBracket LeftBracket
			RBracket RightBracket
			Apostrophe Quote
			Semicolon Semicolon
			Backslash Backslash
			16r032 NonUsHash
			Comma Comma
			Slash Slash
			Period Period
			Grave Grave
			
			"16r41 KeypadDecimal
			16r43 KeypadMultiply
			16r45 KeypadPlus
			16r47 KeypadClear
			16r4B KeypadDivide
			16r4C KeypadEnter
			16r4E KeypadMinus
			16r51 KeypadEquals
			16r52 Keypad0
			16r53 Keypad1
			16r54 Keypad2
			16r55 Keypad3
			16r56 Keypad4
			16r57 Keypad5
			16r58 Keypad6
			16r59 Keypad7
			16r5B Keypad8
			16r5C Keypad9"
		)
]

{ #category : #initialization }
BlGlutinKeyboardKeyTable >> keyFromVirtualCode: aVirtualCode [
	<return: #BlKeyboardKey>

	^ virtualKeyTable
		at: aVirtualCode item
		ifAbsent: [ BlKeyboardKey unknown: aVirtualCode ]
]
