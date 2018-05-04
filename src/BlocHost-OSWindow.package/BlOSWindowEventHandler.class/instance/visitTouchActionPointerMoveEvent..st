visiting - touch
visitTouchActionPointerMoveEvent: anEvent
	| aBlocEvent |

	aBlocEvent := BlTouchMoveEvent new
		position: window windowExtent * anEvent position;
		screenPosition: window position + (window windowExtent * anEvent position);
		delta: window windowExtent * anEvent delta;
		timestamp: DateAndTime now;
		pointerId: anEvent fingerId;
		pressure: anEvent pressure;
		yourself.

	self enqueue: aBlocEvent