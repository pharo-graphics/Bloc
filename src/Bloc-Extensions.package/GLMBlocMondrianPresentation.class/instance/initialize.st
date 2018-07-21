scripting
initialize
	super initialize.
	paintingBlock := [ :aGtMondrian :theDisplayValue | ].
	viewInitializer := [ self createDefaultView ].
	self withNodeClicks.
	self withEdgeClicks.
	self defaultActions