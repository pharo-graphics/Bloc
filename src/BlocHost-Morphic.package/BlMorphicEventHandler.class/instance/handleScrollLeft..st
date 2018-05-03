event handling
handleScrollLeft: anEvent
	self convertMousePosition: anEvent andDo: [ :aMorphicEvent | 
		| aBlEvent |

		aBlEvent := BlMouseWheelEvent new
			vector: (BlVector x: 2 y: 0);
			modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
			button: (BlMouseButton code: aMorphicEvent buttons);
			position: aMorphicEvent position;
			screenPosition: (self globalMousePositionForEvent: aMorphicEvent);
			direction: aMorphicEvent keyCharacter;
			timestamp: DateAndTime now.
		
		self enqueue: aBlEvent ]