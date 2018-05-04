visiting - mouse
visitMouseButtonReleaseEvent: anEvent
	| aBlocEvent |
	
	"we handle touch events separately, therefore ignore `touch` based mouse events"
	anEvent isTouch
		ifTrue: [ ^ self ].

	aBlocEvent := BlMouseUpEvent new
		position: anEvent position;
		screenPosition: window position + anEvent position;
		delta: anEvent delta;
		button: (self convertButton: anEvent button);
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: self time now.
		
	self enqueue: aBlocEvent