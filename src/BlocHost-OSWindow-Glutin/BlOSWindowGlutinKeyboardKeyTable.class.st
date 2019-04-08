Class {
	#name : #BlOSWindowGlutinKeyboardKeyTable,
	#superclass : #BlKeyboardKeyTable,
	#instVars : [
		'virtualKeyTable'
	],
	#classInstVars : [
		'default'
	],
	#category : #'BlocHost-OSWindow-Glutin'
}

{ #category : #cleanup }
BlOSWindowGlutinKeyboardKeyTable class >> cleanUp [
	<script: 'self cleanUp'>
	super cleanUp.
	
	default := nil
]

{ #category : #cleanup }
BlOSWindowGlutinKeyboardKeyTable class >> default [
	^ default ifNil: [ default := self new ]
]

{ #category : #initialization }
BlOSWindowGlutinKeyboardKeyTable >> initialize [
	super initialize.

	self initializeVirtualKeyTable
]

{ #category : #initialization }
BlOSWindowGlutinKeyboardKeyTable >> initializeVirtualKeyTable [
	self
		initialize: (virtualKeyTable := Dictionary new)
		with: #(
			"special"
			16r028 Return
			16r02B Tab
			16r02C Space
			16r04C Delete
			16r02A Backspace
			16r029 Escape
			16r039 CapsLock
			16r3F Function
			
			"modifiers"
			16r0E1 ShiftLeft
			16r0E5 ShiftRight
			16r0E2 AltLeft
			16r0E6 AltRight
			16r0E0 ControlLeft
			16r0E4 ControlRight
			16r0E3 MetaLeft
			16r0E7 MetaRight
			
			"sound"
			16r080 VolumeUp
			16r081 VolumeDown
			16r07F Mute
			16r048 Pause "!!"
			
			"functions"
			16r03A F1
			16r03B F2
			16r03C F3
			16r03D F4
			16r03E F5
			16r03F F6
			16r040 F7
			16r041 F8
			16r042 F9
			16r043 F10
			16r044 F11
			16r045 F12
			
			"navigation"
			16r075 Help
			16r046 PrintScreen "!!"
			16r047 ScrollLock "!!"
			16r049 Insert "!!"
			16r04A Home
			16r04B PageUp
			16r04D End
			16r04E PageDown
			16r050 ArrowLeft
			16r04F ArrowRight
			16r051 ArrowDown
			16r052 ArrowUp
			
			"letters"
			16r004 A
			16r005 B
			16r006 C
			16r007 D
			16r008 E
			16r009 F
			16r00A G
			16r00B H
			16r00C I
			16r00D J
			16r00E K
			16r00F L
			16r010 M
			16r011 N
			16r012 O
			16r013 P
			16r014 Q
			16r015 R
			16r016 S
			16r017 T
			16r018 U
			16r019 V
			16r01A W
			16r01B X
			16r01C Y
			16r01D Z

			"digits"
			16r027 Zero
			16r01E One
			16r01F Two
			16r020 Three
			16r021 Four
			16r022 Five
			16r023 Six
			16r024 Seven
			16r025 Eight
			16r026 Nine

			"symbols"
			16r02D Minus
			16r02E Equal
			16r02F LeftBracket
			16r030 RightBracket
			16r034 Quote "=Apostrophe"
			16r033 Semicolon
			16r031 Backslash
			16r032 NonUsHash "!!"
			16r036 Comma
			16r038 Slash
			16r037 Period
			16r035 Grave
			
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
BlOSWindowGlutinKeyboardKeyTable >> keyFromScanCode: aScanCode [
	<return: #BlKeyboardKey>

	^ virtualKeyTable
		at: aScanCode
		ifAbsent: [ BlKeyboardKey unknown: aScanCode ]
]
