initialization
initialize
	super initialize.
	
	eventHandler := BlMorphicEventHandler window: self.
	
	form := BlExternalForm extent: 1@1 depth: 32.
	form autoRelease.
	color := Color transparent.
	defered := false.
	
	preventResize := false.

	"we prefer to fill parent"
	self hResizing: #spaceFill.
	self vResizing: #spaceFill