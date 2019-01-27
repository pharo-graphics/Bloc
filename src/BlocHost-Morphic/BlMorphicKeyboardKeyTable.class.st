Class {
	#name : #BlMorphicKeyboardKeyTable,
	#superclass : #Object,
	#classVars : [
		'MacosVirtualKeyTable',
		'UnixVirtualKeyTable',
		'WindowsVirtualKeyTable'
	],
	#category : #'BlocHost-Morphic-Host'
}

{ #category : #'class initialization' }
BlMorphicKeyboardKeyTable class >> initialize [
	self
		initializeMacOSVirtualKeyTable;
		initializeUnixVirtualKeyTable;
		initializeWindowsVirtualKeyTable
]

{ #category : #private }
BlMorphicKeyboardKeyTable class >> initialize: aMapDictionary with: aMapArray [
	aMapArray pairsDo: [ :eachCode :eachName |
		| aName |
		aName := (BlKeyboardKey respondsTo: eachName)
			ifTrue: [ eachName ]
			ifFalse: [ (BlKeyboardKey respondsTo: eachName uncapitalized)
				ifTrue: [ eachName uncapitalized ]
				ifFalse: [ #unknown ] ].

		aMapDictionary at: eachCode put: ((BlKeyboardKey perform: aName) setValue: eachCode) ]
]

{ #category : #'map - macos' }
BlMorphicKeyboardKeyTable class >> initializeMacOSVirtualKeyTable [
	<script: 'self initializeMacOSVirtualKeyTable'>

	self
		initialize: (MacosVirtualKeyTable := Dictionary new)
		with: #(
			16r24 Return
			16r30 Tab
			16r31 Space
			16r33 Delete
			16r35 Escape
			16r39 CapsLock
			
			16r38 ShiftLeft
			16r3C ShiftRight
			16r3A AltLeft
			16r3D AltRight
			16r3B ControlLeft
			16r3E ControlRight
			16r37 MetaLeft
			16r36 MetaRight
	
			16r3F Function
			16r48 VolumeUp
			16r49 VolumeDown
			16r4A Mute
			16r7A F1
			16r78 F2
			16r63 F3
			16r76 F4
			16r60 F5
			16r61 F6
			16r62 F7
			16r64 F8
			16r65 F9
			16r67 F11
			16r6D F10
			16r6F F12
			16r72 Help
			16r73 Home
			16r74 PageUp
			16r75 ForwardDelete
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
BlMorphicKeyboardKeyTable class >> initializeUnixVirtualKeyTable [
	<script: 'self initializeUnixVirtualKeyTable'>

	self
		initialize: (UnixVirtualKeyTable := Dictionary new)
		with: #(
			"special"
			16r0D Return
			16r09 Tab
			16r20 Space
			16r7F Delete
			16r08 Backspace
			16r1B Escape
			16rFD CapsLock
			16r3F Function
			
			"modifiers"
			16rFF ShiftLeft
			16rFE ShiftRight
			16r3A AltLeft
			16r3D AltRight
			16r3B ControlLeft
			16r3E ControlRight
			16r37 MetaLeft
			16r36 MetaRight
	
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
			16r67 F11
			16r6D F10
			16r6F F12
			
			"navigation"
			16r72 Help
			16r73 Home
			16r74 PageUp
			16r75 ForwardDelete
			16r77 End
			16r79 PageDown
			16r7B ArrowLeft
			16r7C ArrowRight
			16r7D ArrowDown
			16r7E ArrowUp
			
			"letters"
			16r61 A
			16r62 B
			16r63 C
			16r64 D
			16r65 E
			16r66 F
			16r67 G
			16r68 H
			16r69 I
			16r6A J
			16r6B K
			16r6C L
			16r6D M
			16r6E N
			16r6F O
			16r70 P
			16r71 Q
			16r72 R
			16r73 S
			16r74 T
			16r75 U
			16r76 V
			16r77 W
			16r78 X
			16r79 Y
			16r7A Z
			
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
			16r21 LeftBracket
			16r1E RightBracket
			16r27 Quote
			16r29 Semicolon
			16r2A Backslash
			16r2B Comma
			16r2C Slash
			16r2F Period
			16r60 Grave
			
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
		).
]

{ #category : #'map - windows' }
BlMorphicKeyboardKeyTable class >> initializeWindowsVirtualKeyTable [
	<script: 'self initializeWindowsVirtualKeyTable'>

	self
		initialize: (WindowsVirtualKeyTable := Dictionary new)
		with: #(
			16r0d Return
			16r09 Tab
			16r20 Space
			16r2e Delete
			16r1b Escape
			16r5B Command
			16r5c Command
			16r10 Shift
			16r14 CapsLock
			16r12 Option
			16r11 Control
			16ra0 RightShift
			16ra5 RightOption
			16ra3 RightControl
			-1 Function
			16raf VolumeUp
			16rae VolumeDown
			16rad Mute
			16r70 F1
			16r71 F2
			16r72 F3
			16r73 F4
			16r74 F5
			16r75 F6
			16r76 F7
			16r77 F8
			16r78 F9
			16r79 F11
			16r7a F10
			16r7b F12
			16r2f Help
			16r24 Home
			16r21 PageUp
			16r2e ForwardDelete
			16r23 End
			16r22 PageDown
			16r1c LeftArrow
			16r1d RightArrow
			16r1f DownArrow
			16r1e UpArrow
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

			16rbd Minus
			61 Equal
			16rdb LeftBracket
			16rdd RightBracket
			1 Quote
			16rba Semicolon
			16rbf Backslash
			16rbc Comma
			16rdc Slash
			16rbe Period
			16rc0 Grave
			16r6e KeypadDecimal
			16r6a KeypadMultiply
			16r6b KeypadPlus
			16r0c KeypadClear
			16r6f KeypadDivide
			16r0d KeypadEnter
			16r6d KeypadMinus
			1 KeypadEquals
			16r60 Keypad0
			16r61 Keypad1
			16r62 Keypad2
			16r63 Keypad3
			16r64 Keypad4
			16r65 Keypad5
			16r66 Keypad6
			16r67 Keypad7
			16r68 Keypad8
			16r69 Keypad9
		)
]

{ #category : #'map - macos' }
BlMorphicKeyboardKeyTable class >> macOSVirtualKeyTable [
	MacosVirtualKeyTable ifNil: [ self initializeMacOSVirtualKeyTable. ].
	^ MacosVirtualKeyTable
]

{ #category : #'map - unix' }
BlMorphicKeyboardKeyTable class >> unixVirtualKeyTable [
	UnixVirtualKeyTable ifNil: [ self initializeUnixVirtualKeyTable. ].
	^UnixVirtualKeyTable
]

{ #category : #'map - macos' }
BlMorphicKeyboardKeyTable class >> valueForMacOSXPlatform: aKeyValue [

	^self macOSVirtualKeyTable at: aKeyValue ifAbsent: [ BlKeyboardKey unknown: aKeyValue ]
]

{ #category : #'map - unix' }
BlMorphicKeyboardKeyTable class >> valueForUnixPlatform: aKeyValue [

	^ self unixVirtualKeyTable at: aKeyValue ifAbsent: [ BlKeyboardKey unknown: aKeyValue ] 
]

{ #category : #'map - windows' }
BlMorphicKeyboardKeyTable class >> valueForWindowsPlatform: aKeyCode [

	^ self windowsVirtualKeyTable at: aKeyCode ifAbsent: [ (self basicNew withValue: aKeyCode andName: #Unknown) ] 
]

{ #category : #'map - windows' }
BlMorphicKeyboardKeyTable class >> windowsVirtualKeyTable [

	WindowsVirtualKeyTable ifNil: [ self initializeWindowsVirtualKeyTable. ].
	^ WindowsVirtualKeyTable
]
