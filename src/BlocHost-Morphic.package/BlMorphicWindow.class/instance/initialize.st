initialization
initialize
	super initialize.

	spaceForm := BlMorphicExternalFormMorph new.
	self addMorph: spaceForm fullFrame: (0@0 extent: 1@1).
	eventHandler := BlMorphicEventHandler window: self.
	mutex := Mutex new.
	preventResize := false