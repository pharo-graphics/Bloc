event handling
handleMouseWheel: anEvent
	self convertMousePosition: anEvent andDo: [ :aMorphicEvent | 
		| aBlEvent |

		aBlEvent := BlMouseWheelEvent new
			vector: (BlVector x: 0 y: (aMorphicEvent direction = Character arrowDown
				ifTrue: [ -2 ] ifFalse: [ 2 ]));
			modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
			position: aMorphicEvent position;
			screenPosition: (self globalMousePositionForEvent: aMorphicEvent);
			direction: aMorphicEvent direction;
			timestamp: DateAndTime now.
		
		self enqueue: aBlEvent ]