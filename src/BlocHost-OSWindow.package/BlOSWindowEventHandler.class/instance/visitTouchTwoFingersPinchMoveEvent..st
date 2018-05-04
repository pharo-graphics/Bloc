visiting - gestures
visitTouchTwoFingersPinchMoveEvent: anEvent
	| aBlocEvent |

	aBlocEvent := BlGesturePinchEvent new
		distance: anEvent dDist;
		position: anEvent position;
		screenPosition: window position + anEvent position;
		delta: anEvent delta;
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: self time now;
		yourself.

	self enqueue: aBlocEvent