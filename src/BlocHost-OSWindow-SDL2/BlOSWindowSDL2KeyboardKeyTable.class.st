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
			13 . BlKeyboardKey return.
			9 . BlKeyboardKey tab.
			32 . BlKeyboardKey space.
			127 . BlKeyboardKey delete.
			8 . BlKeyboardKey backspace.
			27 . BlKeyboardKey escape.
			1073741881 . BlKeyboardKey capsLock.
		
			"modifiers"
			1073742049 . BlKeyboardKey shiftLeft.
			1073742053 . BlKeyboardKey shiftRight.
			1073742050 . BlKeyboardKey altLeft.
			1073742054 . BlKeyboardKey altRight.
			1073742048 . BlKeyboardKey controlLeft.
			1073742052 . BlKeyboardKey controlRight.
			1073742051 . BlKeyboardKey metaLeft.
			1073742055 . BlKeyboardKey metaRight.
			
			"sound"
			1073741952 . BlKeyboardKey volumeUp.
			1073741953 . BlKeyboardKey volumeDown.
			1073741951 . BlKeyboardKey mute.
			"16r048 . BlKeyboardKey pause".
			
			"functions"
			1073741882 . BlKeyboardKey F1.
			1073741883 . BlKeyboardKey F2.
			1073741884 . BlKeyboardKey F3.
			1073741885 . BlKeyboardKey F4.
			1073741886 . BlKeyboardKey F5.
			1073741887 . BlKeyboardKey F6.
			1073741888 . BlKeyboardKey F7.
			1073741889 . BlKeyboardKey F8.
			1073741890 . BlKeyboardKey F9.
			1073741891 . BlKeyboardKey F10.
			1073741892 . BlKeyboardKey F11.
			1073741893 . BlKeyboardKey F12.
			
			"navigation"
			"16r075 . BlKeyboardKey help.
			16r046 . BlKeyboardKey printScreen.
			16r047 . BlKeyboardKey scrollLock.
			16r049 . BlKeyboardKey insert."
			1073741898 . BlKeyboardKey home.
			1073741899 . BlKeyboardKey pageUp.
			1073741901 . BlKeyboardKey end.
			1073741902 . BlKeyboardKey pageDown.
			1073741904 . BlKeyboardKey arrowLeft.
			1073741903 . BlKeyboardKey arrowRight.
			1073741905 . BlKeyboardKey arrowDown.
			1073741906 . BlKeyboardKey arrowUp.
			
			"letters"
			97 . BlKeyboardKey a.
			98 . BlKeyboardKey b.
			99 . BlKeyboardKey c.
			100 . BlKeyboardKey d.
			101 . BlKeyboardKey e.
			102 . BlKeyboardKey f.
			103 . BlKeyboardKey g.
			104 . BlKeyboardKey h.
			105 . BlKeyboardKey i.
			106 . BlKeyboardKey j.
			107 . BlKeyboardKey k.
			108 . BlKeyboardKey l.
			109 . BlKeyboardKey m.
			110 . BlKeyboardKey n.
			111 . BlKeyboardKey o.
			112 . BlKeyboardKey p.
			113 . BlKeyboardKey q.
			114 . BlKeyboardKey r.
			115 . BlKeyboardKey s.
			116 . BlKeyboardKey t.
			117 . BlKeyboardKey u.
			118 . BlKeyboardKey v.
			119 . BlKeyboardKey w.
			120 . BlKeyboardKey x.
			121 . BlKeyboardKey y.
			122 . BlKeyboardKey z.

			"digits"
			48 . BlKeyboardKey zero.
			49 . BlKeyboardKey one.
			50 . BlKeyboardKey two.
			51 . BlKeyboardKey three.
			52 . BlKeyboardKey four.
			53 . BlKeyboardKey five.
			54 . BlKeyboardKey six.
			55 . BlKeyboardKey seven.
			56 . BlKeyboardKey eight.
			57 . BlKeyboardKey nine.

			"symbols"
			45 . BlKeyboardKey minus.
			61 . BlKeyboardKey equal.
			91 . BlKeyboardKey leftBracket.
			93 . BlKeyboardKey rightBracket.
			39 . BlKeyboardKey quote. "=Apostrophe"
			59 . BlKeyboardKey semicolon.
			92 . BlKeyboardKey backslash.
			"16r032 . BlKeyboardKey nonUsHash."
			44 . BlKeyboardKey comma.
			47 . BlKeyboardKey slash.
			46 . BlKeyboardKey period.
			96 . BlKeyboardKey grave.
			
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
	<return: #BlKeyboardKey>

	^ virtualKeyTable
		at: aVirtualCode
		ifAbsent: [ BlKeyboardKey unknown: aVirtualCode ]
]
