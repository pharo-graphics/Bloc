accessing
initialize
	super initialize.
	self background: (Color gray alpha: 0.1 ).
	self border: (BlBorder paint: Color black width: 1 style: BlStrokeStyle DOTTED).
	self initializeHandlers.
	self initializeActions