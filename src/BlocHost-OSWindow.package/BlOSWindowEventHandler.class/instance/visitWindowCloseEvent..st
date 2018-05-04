visiting window
visitWindowCloseEvent: anEvent
	| aBlocEvent |
	anEvent suppressDefaultAction.

	aBlocEvent := BlSpaceCloseRequest new
		timestamp: self time now;
		yourself.
		
	self enqueue: aBlocEvent