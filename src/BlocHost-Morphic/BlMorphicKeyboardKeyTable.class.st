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
	"self
		initializeMacOSVirtualKeyTable;
		initializeUnixVirtualKeyTable;
		initializeWindowsVirtualKeyTable"
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
			16r1C Eigth
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
	UnixVirtualKeyTable := Dictionary new.
	UnixVirtualKeyTable
		at: Character cr asciiValue put: (self value: 16rff0d); " kVK_Return       = 0x24"
		at: Character tab asciiValue put: (self value: 16rff09); "  kVK_Tab        = 0x30"
		at: Character space asciiValue put: (self value: 16rff80); "  kVK_Space    = 0x31"
		at: Character delete asciiValue put: (self value: 16rffff); "  kVK_Delete  = 0x33"
		at: Character escape asciiValue put: (self value: 16rff1b); "  kVK_Escape  = 0x35"
		at: 8 put: (self value: 16rff08); "  kVK_Command                           = 0x37"
		at: -1 put: (self value: 16rffe7); "  kVK_Command                          = 0x37"
		at: 255 put: (self value: 16rffe1); "  kVK_Shift                           = 0x38"
		at: -1 put: (self value: 16rffe5); "  kVK_CapsLock                         = 0x39"
		at: 247 put: (self value: 16rffe9); "  kVK_Option                          = 0x3A"
		at: 251 put: (self value: 16rffe3); "  kVK_Control                         = 0x3B"
		at: 254 put: (self value: 16rffe2); "  kVK_RightShift                      = 0x3C"
      at: 246 put: (self value: 16rffea); " kVK_RightOption                      = 0x3D"
      at: 250 put: (self value: 16rffe4); " kVK_RightControl                     = 0x3E"
		at: -1 put: (self value: 16r08f6); "  kVK_Function                         = 0x3F"
		at: -1 put: (self value: 16r48); "  kVK_VolumeUp                           = 0x48"  "Not mapped"
		at: -1 put: (self value: 16r49); "  kVK_VolumeDown                         = 0x49" "Not mapped"
		at: -1 put: (self value: 16r4A); "  kVK_Mute                               = 0x4A" "Not mapped"
		at: -1 put: (self value: 16rffbe); "  kVK_F1                               = 0x7A"
		at: -1 put: (self value: 16rffbf); "  kVK_F2                               = 0x78"
		at: -1 put: (self value: 16rffc0); "  kVK_F3                               = 0x63"
		at: -1 put: (self value: 16rffc1); "  kVK_F4                               = 0x76"
		at: -1 put: (self value: 16rffc2); "  kVK_F5                               = 0x60"
		at: -1 put: (self value: 16rffc3); "  kVK_F6                               = 0x61"
		at: -1 put: (self value: 16rffc4); "  kVK_F7                               = 0x62"
		at: -1 put: (self value: 16rffc5); "  kVK_F8                               = 0x64"
		at: -1 put: (self value: 16rffc6); "  kVK_F9                               = 0x65"
		at: -1 put: (self value: 16rffc8); "  kVK_F11                              = 0x67"
		at: -1 put: (self value: 16rffc7); "  kVK_F10                              = 0x6D"
		at: -1 put: (self value: 16rffc9); "  kVK_F12                              = 0x6F"
		at: -1 put: (self value: 16r72); "  kVK_Help                               = 0x72" "Not mapped"
		at: Character home asciiValue put: (self value: 16rff50); "  kVK_Home      = 0x73"
		at: Character pageUp asciiValue put: (self value: 16rff55); "  kVK_PageUp  = 0x74"
		at: Character delete asciiValue put: (self value: 16rffff); "  kVK_ForwardDelete   = 0x75"
		at: Character end asciiValue put: (self value: 16rff57); "  kVK_End                = 0x77"
		at: Character pageDown asciiValue put: (self value: 16rff56); "  kVK_PageDown      = 0x79"
		at: Character arrowLeft asciiValue put: (self value: 16rff96); "  kVK_LeftArrow    = 0x7B"
		at: Character arrowRight asciiValue put: (self value: 16rff98); "  kVK_RightArrow  = 0x7C"
		at: Character arrowDown asciiValue put: (self value: 16rff99); "  kVK_DownArrow    = 0x7D"
		at: Character arrowUp asciiValue put: (self value: 16rff97); "  kVK_UpArrow        = 0x7E"
		at: $a asciiValue put: (self value: 16r41); "kVK_ANSI_A                    = 0x00"
		at: $b asciiValue put: (self value: 16r42); "  kVK_ANSI_B                  = 0x0B"
		at: $c asciiValue put: (self value: 16r43); "  kVK_ANSI_C                  = 0x08"
		at: $d asciiValue put: (self value: 16r44); "  kVK_ANSI_D                  = 0x02"
		at: $e asciiValue put: (self value: 16r45); "  kVK_ANSI_E                  = 0x0E"
		at: $f asciiValue put: (self value: 16r46); "  kVK_ANSI_F                  = 0x03"
		at: $g asciiValue put: (self value: 16r47); "  kVK_ANSI_G                  = 0x05"
		at: $h asciiValue put: (self value: 16r48); "  kVK_ANSI_H                  = 0x04"
		at: $i asciiValue put: (self value: 16r49); "  kVK_ANSI_I                  = 0x22"
		at: $j asciiValue put: (self value: 16r4a); "  kVK_ANSI_J                  = 0x26"
		at: $k asciiValue put: (self value: 16r4b); "  kVK_ANSI_K                  = 0x28"
		at: $l asciiValue put: (self value: 16r4c); "  kVK_ANSI_L                  = 0x25"
		at: $m asciiValue put: (self value: 16r4d); "  kVK_ANSI_M                  = 0x2E"
		at: $n asciiValue put: (self value: 16r4e); "  kVK_ANSI_N                  = 0x2D"
		at: $o asciiValue put: (self value: 16r4f); "  kVK_ANSI_O                  = 0x1F"
		at: $p asciiValue put: (self value: 16r50); "  kVK_ANSI_P                  = 0x23"
		at: $q asciiValue put: (self value: 16r51); "  kVK_ANSI_Q                  = 0x0C"
		at: $r asciiValue put: (self value: 16r52); "  kVK_ANSI_R                  = 0x0F"
		at: $s asciiValue put: (self value: 16r53); "  kVK_ANSI_S                  = 0x01"
		at: $t asciiValue put: (self value: 16r54); "  kVK_ANSI_T                  = 0x11"
		at: $u asciiValue put: (self value: 16r55); "  kVK_ANSI_U                  = 0x20"
		at: $v asciiValue put: (self value: 16r56); "  kVK_ANSI_V                  = 0x09"
		at: $w asciiValue put: (self value: 16r57); "  kVK_ANSI_W                  = 0x0D"
		at: $x asciiValue put: (self value: 16r58); "  kVK_ANSI_X                  = 0x07"
		at: $y asciiValue put: (self value: 16r59); "  kVK_ANSI_Y                  = 0x10"
		at: $z asciiValue put: (self value: 16r5a); "  kVK_ANSI_Z                  = 0x06"
		
		at: $0 asciiValue put: (self value: 16r30); "  kVK_ANSI_0                  = 0x1D"
		at: $1 asciiValue put: (self value: 16r31); "  kVK_ANSI_1                  = 0x12"
		at: $2 asciiValue put: (self value: 16r32); "  kVK_ANSI_2                  = 0x13"
		at: $3 asciiValue put: (self value: 16r33); "  kVK_ANSI_3                  = 0x14"
		at: $4 asciiValue put: (self value: 16r34); "  kVK_ANSI_4                  = 0x15"
		at: $5 asciiValue put: (self value: 16r35); "  kVK_ANSI_5                  = 0x17"
		at: $6 asciiValue put: (self value: 16r36); "  kVK_ANSI_6                  = 0x16"
		at: $7 asciiValue put: (self value: 16r37); "  kVK_ANSI_7                  = 0x1A"
		at: $8 asciiValue put: (self value: 16r38); "  kVK_ANSI_8                  = 0x1C"
		at: $9 asciiValue put: (self value: 16r39); "  kVK_ANSI_9                  = 0x19"

		at: $- asciiValue put: (self value: 16r2d); "  kVK_ANSI_Minus              = 0x1B"
		at: $= asciiValue put: (self value: 16r3d); "  kVK_ANSI_Equal              = 0x18"
		at: $[ asciiValue put: (self value: 16r5b); "  kVK_ANSI_LeftBracket        = 0x21"
		at: $] asciiValue put: (self value: 16r5d); "  kVK_ANSI_RightBracket       = 0x1E"
		at: $' asciiValue put: (self value: 16r27); "  kVK_ANSI_Quote              = 0x27"
		at: $; asciiValue put: (self value: 16r3b); "  kVK_ANSI_Semicolon          = 0x29"
		at: $/ asciiValue put: (self value: 16r5c); "  kVK_ANSI_Backslash          = 0x2A"
		at: $, asciiValue put: (self value: 16r2c); "  kVK_ANSI_Comma              = 0x2B"
		at: $\ asciiValue put: (self value: 16r2f); "  kVK_ANSI_Slash              = 0x2C"
		at: $. asciiValue put: (self value: 16r2e); "  kVK_ANSI_Period             = 0x2F"
		at: $` asciiValue put: (self value: 16r60); "  kVK_ANSI_Grave              = 0x32"
		at: 1 put: (self value: 16rffae); "  kVK_ANSI_KeypadDecimal                = 0x41"
		at: 1 put: (self value: 16rffaa); "  kVK_ANSI_KeypadMultiply               = 0x43"
		at: 1 put: (self value: 16rffab); "  kVK_ANSI_KeypadPlus                   = 0x45"
		at: 1 put: (self value: 16r47); "  kVK_ANSI_KeypadClear                    = 0x47" "Not mapped"
		at: 1 put: (self value: 16rffaf); "  kVK_ANSI_KeypadDivide                 = 0x4B"
		at: 1 put: (self value: 16rff8d); "  kVK_ANSI_KeypadEnter                  = 0x4C"
		at: 1 put: (self value: 16rffad); "  kVK_ANSI_KeypadMinus                  = 0x4E"
		at: 1 put: (self value: 16rffbd); "  kVK_ANSI_KeypadEquals                 = 0x51"
		at: 1 put: (self value: 16rffb0); "  kVK_ANSI_Keypad0                      = 0x52"
		at: 1 put: (self value: 16rffb1); "  kVK_ANSI_Keypad1                      = 0x53"
		at: 1 put: (self value: 16rffb2); "  kVK_ANSI_Keypad2                      = 0x54"
		at: 1 put: (self value: 16rffb3); "  kVK_ANSI_Keypad3                      = 0x55"
		at: 1 put: (self value: 16rffb4); "  kVK_ANSI_Keypad4                      = 0x56"
		at: 1 put: (self value: 16rffb5); "  kVK_ANSI_Keypad5                      = 0x57"
		at: 1 put: (self value: 16rffb6); "  kVK_ANSI_Keypad6                      = 0x58"
		at: 1 put: (self value: 16rffb7); "  kVK_ANSI_Keypad7                      = 0x59"
		at: 1 put: (self value: 16rffb8); "  kVK_ANSI_Keypad8                      = 0x5B"
		at: 1 put: (self value: 16rffb9) "  kVK_ANSI_Keypad9                       = 0x5C"
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
	^MacosVirtualKeyTable
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

	^self unixVirtualKeyTable at: aKeyValue ifAbsent: [ (self basicNew withValue: aKeyValue) ] 
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
