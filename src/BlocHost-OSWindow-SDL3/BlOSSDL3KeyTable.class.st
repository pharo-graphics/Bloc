"
I map SDL3 Keycodes to Pharo KeyboardKeys

"
Class {
	#name : #BlOSSDL3KeyTable,
	#superclass : #BlKeyboardKeyTable,
	#instVars : [
		'virtualKeyTable'
	],
	#pools : [
		'SDL3KeyConstants'
	],
	#classInstVars : [
		'default'
	],
	#category : #'BlocHost-OSWindow-SDL3'
}

{ #category : #cleanup }
BlOSSDL3KeyTable class >> cleanUp [
	<script: 'self cleanUp'>
	super cleanUp.
	
	default := nil
]

{ #category : #cleanup }
BlOSSDL3KeyTable class >> default [
	^ default ifNil: [ default := self new ]
]

{ #category : #initialization }
BlOSSDL3KeyTable >> initialize [

	super initialize.

	self
		initialize: (virtualKeyTable := Dictionary new)
		withKeys: {
			"special"
			SDLK_RETURN. KeyboardKey enter.
			SDLK_TAB. KeyboardKey tab.
			SDLK_SPACE. KeyboardKey space.
			SDLK_DELETE. KeyboardKey delete.
			SDLK_BACKSPACE. KeyboardKey backspace.
			SDLK_ESCAPE. KeyboardKey escape.
			SDLK_CAPSLOCK. KeyboardKey capsLock.
		
			"modifiers"
			SDLK_LSHIFT. KeyboardKey shiftLeft.
			SDLK_RSHIFT. KeyboardKey shiftRight.
			SDLK_LALT. KeyboardKey altLeft.
			SDLK_RALT. KeyboardKey altRight.
			SDLK_LCTRL. KeyboardKey controlLeft.
			SDLK_RCTRL. KeyboardKey controlRight.
			SDLK_LGUI. KeyboardKey metaLeft.
			SDLK_RGUI. KeyboardKey metaRight.
			
			"functions"
			SDLK_F1. KeyboardKey F1.
			SDLK_F2. KeyboardKey F2.
			SDLK_F3. KeyboardKey F3.
			SDLK_F4. KeyboardKey F4.
			SDLK_F5. KeyboardKey F5.
			SDLK_F6. KeyboardKey F6.
			SDLK_F7. KeyboardKey F7.
			SDLK_F8. KeyboardKey F8.
			SDLK_F9. KeyboardKey F9.
			SDLK_F10. KeyboardKey F10.
			SDLK_F11. KeyboardKey F11.
			SDLK_F12. KeyboardKey F12.
			
			"navigation"
			SDLK_HOME. KeyboardKey home.
			SDLK_PAGEUP. KeyboardKey pageUp.
			SDLK_END. KeyboardKey end.
			SDLK_PAGEDOWN. KeyboardKey pageDown.
			SDLK_LEFT. KeyboardKey left.
			SDLK_RIGHT. KeyboardKey right.
			SDLK_DOWN. KeyboardKey down.
			SDLK_UP. KeyboardKey up.
			
			"letters"
			SDLK_A. KeyboardKey A.
			SDLK_B. KeyboardKey B.
			SDLK_C. KeyboardKey C.
			SDLK_D. KeyboardKey D.
			SDLK_E. KeyboardKey E.
			SDLK_F. KeyboardKey F.
			SDLK_G. KeyboardKey G.
			SDLK_H. KeyboardKey H.
			SDLK_I. KeyboardKey I.
			SDLK_J. KeyboardKey J.
			SDLK_K. KeyboardKey K.
			SDLK_L. KeyboardKey L.
			SDLK_M. KeyboardKey M.
			SDLK_N. KeyboardKey N.
			SDLK_O. KeyboardKey O.
			SDLK_P. KeyboardKey P.
			SDLK_Q. KeyboardKey Q.
			SDLK_R. KeyboardKey R.
			SDLK_S. KeyboardKey S.
			SDLK_T. KeyboardKey T.
			SDLK_U. KeyboardKey U.
			SDLK_V. KeyboardKey V.
			SDLK_W. KeyboardKey W.
			SDLK_X. KeyboardKey X.
			SDLK_Y. KeyboardKey Y.
			SDLK_Z. KeyboardKey Z.

			"digits"
			SDLK_0. KeyboardKey zero.
			SDLK_1. KeyboardKey one.
			SDLK_2. KeyboardKey two.
			SDLK_3. KeyboardKey three.
			SDLK_4. KeyboardKey four.
			SDLK_5. KeyboardKey five.
			SDLK_6. KeyboardKey six.
			SDLK_7. KeyboardKey seven.
			SDLK_8. KeyboardKey eight.
			SDLK_9. KeyboardKey nine.

			"symbols"
			SDLK_MINUS. KeyboardKey minus.
			SDLK_EQUALS. KeyboardKey equal.
			SDLK_LEFTBRACKET. KeyboardKey bracketLeft.
			SDLK_RIGHTBRACKET. KeyboardKey bracketRight.
			SDLK_APOSTROPHE. KeyboardKey quote.
			SDLK_SEMICOLON. KeyboardKey semicolon.
			SDLK_BACKSLASH. KeyboardKey backslash.
			SDLK_COMMA. KeyboardKey comma.
			SDLK_SLASH. KeyboardKey slash.
			SDLK_PERIOD. KeyboardKey period.
			SDLK_GRAVE. KeyboardKey grave.
		}
]

{ #category : #'api - converting' }
BlOSSDL3KeyTable >> keyFromVirtualCode: aVirtualCode [

	^ virtualKeyTable
		at: aVirtualCode
		ifAbsent: [ KeyboardKey new withValue: aVirtualCode ]
]
