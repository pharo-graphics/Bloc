Class {
	#name : #BlOSWindowSDL2KeyboardKeyTable,
	#superclass : #BlKeyboardKeyTable,
	#instVars : [
		'virtualKeyTable'
	],
	#classInstVars : [
		'default'
	],
	#category : #'BlocHost-OSWindow-SDL2'
}

{ #category : #cleanup }
BlOSWindowSDL2KeyboardKeyTable class >> cleanUp [
	<script: 'self cleanUp'>
	super cleanUp.
	
	default := nil
]

{ #category : #cleanup }
BlOSWindowSDL2KeyboardKeyTable class >> default [
	^ default ifNil: [ default := self new ]
]

{ #category : #initialization }
BlOSWindowSDL2KeyboardKeyTable >> initialize [
	super initialize.

	self initializeVirtualKeyTable
]

{ #category : #initialization }
BlOSWindowSDL2KeyboardKeyTable >> initializeVirtualKeyTable [
	"See https://wiki.libsdl.org/SDLKeycodeLookup"

	self
		initialize: (virtualKeyTable := Dictionary new)
		withKeys: {
			"special"
			13 . KeyboardKey enter.
			9 . KeyboardKey tab.
			32 . KeyboardKey space.
			127 . KeyboardKey delete.
			8 . KeyboardKey backspace.
			27 . KeyboardKey escape.
			1073741881 . KeyboardKey capsLock.
		
			"modifiers"
			1073742049 . KeyboardKey shiftLeft.
			1073742053 . KeyboardKey shiftRight.
			1073742050 . KeyboardKey altLeft.
			1073742054 . KeyboardKey altRight.
			1073742048 . KeyboardKey controlLeft.
			1073742052 . KeyboardKey controlRight.
			1073742051 . KeyboardKey metaLeft.
			1073742055 . KeyboardKey metaRight.
			
			"sound"
			"1073741952 . KeyboardKey volumeUp.
			1073741953 . KeyboardKey volumeDown.
			1073741951 . KeyboardKey mute."
			"16r048 . KeyboardKey pause".
			
			"functions"
			1073741882 . KeyboardKey F1.
			1073741883 . KeyboardKey F2.
			1073741884 . KeyboardKey F3.
			1073741885 . KeyboardKey F4.
			1073741886 . KeyboardKey F5.
			1073741887 . KeyboardKey F6.
			1073741888 . KeyboardKey F7.
			1073741889 . KeyboardKey F8.
			1073741890 . KeyboardKey F9.
			1073741891 . KeyboardKey F10.
			1073741892 . KeyboardKey F11.
			1073741893 . KeyboardKey F12.
			
			"navigation"
			"16r075 . KeyboardKey help.
			16r046 . KeyboardKey printScreen.
			16r047 . KeyboardKey scrollLock.
			16r049 . KeyboardKey insert."
			1073741898 . KeyboardKey home.
			1073741899 . KeyboardKey pageUp.
			1073741901 . KeyboardKey end.
			1073741902 . KeyboardKey pageDown.
			1073741904 . KeyboardKey left.
			1073741903 . KeyboardKey right.
			1073741905 . KeyboardKey down.
			1073741906 . KeyboardKey up.
			
			"letters"
			97 . KeyboardKey A.
			98 . KeyboardKey B.
			99 . KeyboardKey C.
			100 . KeyboardKey D.
			101 . KeyboardKey E.
			102 . KeyboardKey F.
			103 . KeyboardKey G.
			104 . KeyboardKey H.
			105 . KeyboardKey I.
			106 . KeyboardKey J.
			107 . KeyboardKey K.
			108 . KeyboardKey L.
			109 . KeyboardKey M.
			110 . KeyboardKey N.
			111 . KeyboardKey O.
			112 . KeyboardKey P.
			113 . KeyboardKey Q.
			114 . KeyboardKey R.
			115 . KeyboardKey S.
			116 . KeyboardKey T.
			117 . KeyboardKey U.
			118 . KeyboardKey V.
			119 . KeyboardKey W.
			120 . KeyboardKey X.
			121 . KeyboardKey Y.
			122 . KeyboardKey Z.

			"digits"
			48 . KeyboardKey zero.
			49 . KeyboardKey one.
			50 . KeyboardKey two.
			51 . KeyboardKey three.
			52 . KeyboardKey four.
			53 . KeyboardKey five.
			54 . KeyboardKey six.
			55 . KeyboardKey seven.
			56 . KeyboardKey eight.
			57 . KeyboardKey nine.

			"symbols"
			45 . KeyboardKey minus.
			61 . KeyboardKey equal.
			91 . KeyboardKey bracketLeft.
			93 . KeyboardKey bracketRight.
			39 . KeyboardKey quote. "=Apostrophe"
			59 . KeyboardKey semicolon.
			92 . KeyboardKey backslash.
			"16r032 . KeyboardKey nonUsHash."
			44 . KeyboardKey comma.
			47 . KeyboardKey slash.
			46 . KeyboardKey period.
			96 . KeyboardKey grave.
			
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
		}
]

{ #category : #'api - converting' }
BlOSWindowSDL2KeyboardKeyTable >> keyFromVirtualCode: aVirtualCode [
	<return: #KeyboardKey>

	^ virtualKeyTable
		at: aVirtualCode
		ifAbsent: [ KeyboardKey new withValue: aVirtualCode ]
]
