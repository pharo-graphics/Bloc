initialization
initialize
	super initialize.
	
	form := BlExternalForm extent: 1@1 depth: 32.
	form autoRelease.
	color := Color transparent.
	defered := false.
	
	eventHandler := BlMorphicEventHandler window: self.
	preventResize := false.

	"we prefer to fill parent"
	self hResizing: #spaceFill.
	self vResizing: #spaceFill