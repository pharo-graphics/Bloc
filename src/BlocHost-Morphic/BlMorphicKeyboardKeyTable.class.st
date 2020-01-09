Class {
	#name : #BlMorphicKeyboardKeyTable,
	#superclass : #BlKeyboardKeyTable,
	#instVars : [
		'macosVirtualKeyTable',
		'unixVirtualKeyTable',
		'windowsVirtualKeyTable'
	],
	#classInstVars : [
		'default'
	],
	#category : #'BlocHost-Morphic-Support'
}

{ #category : #cleanup }
BlMorphicKeyboardKeyTable class >> cleanUp [
	<script: 'self cleanUp'>
	super cleanUp.
	
	default := nil
]

{ #category : #accessing }
BlMorphicKeyboardKeyTable class >> default [
	^ default ifNil: [ default := self new ]
]

{ #category : #initialization }
BlMorphicKeyboardKeyTable >> initialize [
	super initialize.

	self
		initializeMacOSVirtualKeyTable;
		initializeUnixVirtualKeyTable;
		initializeWindowsVirtualKeyTable
]

{ #category : #'map - macos' }
BlMorphicKeyboardKeyTable >> initializeMacOSVirtualKeyTable [

	self
		initialize: (macosVirtualKeyTable := Dictionary new)
		with: #(
			"special"
			16r24 Return
			16r30 Tab
			16r31 Space
			16r33 Delete
			16r75 Backspace
			16r35 Escape
			16r39 CapsLock
			
			"modifiers"
			16r38 ShiftLeft
			16r3C ShiftRight
			16r3A AltLeft
			16r3D AltRight
			16r3B ControlLeft
			16r3E ControlRight
			16r37 MetaLeft
			16r36 MetaRight	
			16r3F Function

			"sound"
			16r48 VolumeUp
			16r49 VolumeDown
			16r4A Mute
			
			"functions"
			16r7A F1
			16r78 F2
			16r63 F3
			16r76 F4
			16r60 F5
			16r61 F6
			16r62 F7
			16r64 F8
			16r65 F9
			16r67 F10
			16r6D F11
			16r6F F12

			16r72 Help
			16r73 Home
			16r74 PageUp
			16r77 End
			16r79 PageDown
			16r7B ArrowLeft
			16r7C ArrowRight
			16r7D ArrowDown
			16r7E ArrowUp
			16r00 A
			16r0B B
			16r08 C
			16r02 D
			16r0E E
			16r03 F
			16r05 G
			16r04 H
			16r22 I
			16r26 J
			16r28 K
			16r25 L
			16r2E M
			16r2D N
			16r1F O
			16r23 P
			16r0C Q
			16r0F R
			16r01 S
			16r11 T
			16r20 U
			16r09 V
			16r0D W
			16r07 X
			16r10 Y
			16r06 Z

			16r1D Zero
			16r12 One
			16r13 Two
			16r14 Three
			16r15 Four
			16r17 Five
			16r16 Six
			16r1A Seven
			16r1C Eight
			16r19 Nine

			"symbols"
			16r1B Minus
			16r18 Equal
			16r21 LeftBracket
			16r1E RightBracket
			16r27 Quote
			16r29 Semicolon
			16r2A Backslash
			16r2B Comma
			16r2C Slash
			16r2F Period
			16r32 Grave
			
			16r41 KeypadDecimal
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
			16r5C Keypad9
		)
]

{ #category : #'map - unix' }
BlMorphicKeyboardKeyTable >> initializeUnixVirtualKeyTable [

	self
		initialize: (unixVirtualKeyTable := Dictionary new)
		with: #(
			"special"
			16r0D Return
			16r09 Tab
			16r20 Space
			16r7F Delete
			16r08 Backspace
			16r1B Escape
			16rFD CapsLock
			
			"modifiers"
			16rFF ShiftLeft
			16rFE ShiftRight
			16rF7 AltLeft
			16rF6 AltRight
			16rFB ControlLeft
			16rFA ControlRight
	
			"sound"
			16r48 VolumeUp
			16r49 VolumeDown
			16r4A Mute
			
			"functions"
			16r7A F1
			16r78 F2
			16r63 F3
			16r76 F4
			16r60 F5
			16r61 F6
			16r62 F7
			16r64 F8
			16r65 F9
			16r67 F10
			16r6D F11
			16r6F F12
			
			"navigation"
			16r72 Help
			16r01 Home	"Character home"
			16r73 Home
			16r74 PageUp
			16r75 ForwardDelete
			16r77 End
			16r04 End 	"Character end"
			16r79 PageDown
			16r1C ArrowLeft
			16r1D ArrowRight
			16r1F ArrowDown
			16r1E ArrowUp
			
			"letters"
			16r61 a
			16r62 b
			16r63 c
			16r64 d
			16r65 e
			16r66 f
			16r67 g
			16r68 h
			16r69 i
			16r6A j
			16r6B k
			16r6C l
			16r6D m
			16r6E n
			16r6F o
			16r70 p
			16r71 q
			16r72 r
			16r73 s
			16r74 t
			16r75 u
			16r76 v
			16r77 w
			16r78 x
			16r79 y
			16r7A z

			16r41 A
			16r42 B
			16r43 C
			16r44 D
			16r45 E
			16r46 F
			16r47 G
			16r48 H
			16r49 I
			16r4A J
			16r4B K
			16r4C L
			16r4D M
			16r4E N
			16r4F O
			16r50 P
			16r51 Q
			16r52 R
			16r53 S
			16r54 T
			16r55 U
			16r56 V
			16r57 W
			16r58 X
			16r59 Y
			16r5A Z
			
			"digits"
			16r30 Zero
			16r31 One
			16r32 Two
			16r33 Three
			16r34 Four
			16r35 Five
			16r36 Six
			16r37 Seven
			16r38 Eight
			16r39 Nine

			"symbols"
			16r2D Minus
			16r3D Equal
			16r5B LeftBracket
			16r7B LeftBracket
			16r5D RightBracket
			16r7D RightBracket
			16r27 Quote
			16r3B Semicolon
			16r5C Backslash
			16r7C Backslash
			16r2C Comma
			16r2F Slash
			16r2E Period
			16r60 Grave
			
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
		).
]

{ #category : #'map - windows' }
BlMorphicKeyboardKeyTable >> initializeWindowsVirtualKeyTable [

	self
		initialize: (windowsVirtualKeyTable := Dictionary new)
		with: #(
			"special"
			16r0D Return
			16r09 Tab
			16r20 Space
			16r7F Delete
			16r08 Backspace
			16r1B Escape
			16r14 CapsLock
			
			"modifiers"
			16r10 ShiftLeft
			"16r10 ShiftRight"
			16r12 AltLeft
			"16r12 AltRight"
			16r11 ControlLeft
			"16r11 ControlRight"
			16r5B MetaLeft
			16r5C MetaRight
			
			"sound"
			16rF8 VolumeUp
			16rA8 VolumeDown
			16rC5 Mute
			
			"functions"
			16r70 F1
			16r71 F2
			16r72 F3
			16r73 F4
			16r74 F5
			16r75 F6
			16r76 F7
			16r77 F8
			16r78 F9
			16r79 F10
			16r7A F11
			16r7B F12
			
			"navigation"
			16r2F Help
			16r24 Home
			16r21 PageUp
			16r2E ForwardDelete
			16r23 End
			16r22 PageDown
			16r1C ArrowLeft
			16r1D ArrowRight
			16r1F ArrowDown
			16r1E ArrowUp

			"letters"
			16r41 A
			16r42 B
			16r43 C
			16r44 D
			16r45 E
			16r46 F
			16r47 G
			16r48 H
			16r49 I
			16r4a J
			16r4b K
			16r4c L
			16r4d M
			16r4e N
			16r4f O
			16r50 P
			16r51 Q
			16r52 R
			16r53 S
			16r54 T
			16r55 U
			16r56 V
			16r57 W
			16r58 X
			16r59 Y
			16r5a Z

			"digits"
			48 Zero
			49 One
			50 Two
			51 Three
			52 Four
			53 Five
			54 Six
			55 Seven
			56 Eight
			57 Nine
			
			"symbols"
			16rDF Minus
			16rC8 Equal
			16rF3 LeftBracket
			16rFA RightBracket
			16rFB Quote
			16rBC Semicolon
			16r86 Backslash
			16rDE Comma
			16rC0 Slash
			16rF0 Period
			16rCB Grave
		)
]

{ #category : #'api - converting' }
BlMorphicKeyboardKeyTable >> keyFromVirtualCode: aVirtualCode [
	"Morphic's key scan codes depend on the current platform, therefore we have to dispatch it through OSPlatform"
	<return: #BlKeyboardKey>

	^ OSPlatform current blocKeyFor: aVirtualCode in: self
]

{ #category : #'map - macos' }
BlMorphicKeyboardKeyTable >> valueForMacOSXPlatform: aScanCode [

	^ macosVirtualKeyTable
		at: aScanCode
		ifAbsent: [ BlKeyboardKey unknown: aScanCode ]
]

{ #category : #'map - unix' }
BlMorphicKeyboardKeyTable >> valueForUnixPlatform: aScanCode [

	^ unixVirtualKeyTable
		at: aScanCode
		ifAbsent: [ BlKeyboardKey unknown: aScanCode ] 
]

{ #category : #'map - windows' }
BlMorphicKeyboardKeyTable >> valueForWindowsPlatform: aScanCode [

	^ windowsVirtualKeyTable
		at: aScanCode
		ifAbsent: [ BlKeyboardKey unknown: aScanCode ]
]
