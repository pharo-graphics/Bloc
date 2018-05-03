private - testing
isScrollEvent: aMorphicKeyEvent
	"Return true if a given morphic key event is in fact a scroll event.
	It is a morphic issue, that mouse wheel or touchpad events are
	in fact keyboard events..."

	^ (aMorphicKeyEvent shiftPressed
			and: [ aMorphicKeyEvent controlKeyPressed
				and: [ aMorphicKeyEvent optionKeyPressed
					and: [ aMorphicKeyEvent keyCharacter = Character arrowDown
						or: [ aMorphicKeyEvent keyCharacter = Character arrowUp
							or: [ aMorphicKeyEvent keyCharacter = Character arrowLeft
								or: [ aMorphicKeyEvent keyCharacter = Character arrowRight
									or: [ aMorphicKeyEvent keyCharacter = Character null ] ] ] ] ] ] ])