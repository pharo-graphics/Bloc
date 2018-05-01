event handling
handleKeystroke: aMorphicEvent
	| aBlEvent |
	
	(aMorphicEvent shiftPressed and: [ aMorphicEvent controlKeyPressed ])
		ifTrue: [
			aMorphicEvent keyCharacter = Character arrowLeft
				ifTrue: [ ^ self handleScrollLeft: aMorphicEvent ].
			aMorphicEvent keyCharacter = Character arrowRight
				ifTrue: [ ^ self handleScrollRight: aMorphicEvent ] ].
	
	aBlEvent := BlKeystrokeEvent new
		char: aMorphicEvent keyCharacter;
		scanCode: aMorphicEvent scanCode;
		
		modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
		timestamp: DateAndTime now;
		position: aMorphicEvent position;
		screenPosition: (self globalMousePositionForEvent: aMorphicEvent).
	
	self enqueue: aBlEvent