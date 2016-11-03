accessing
initialize
	super initialize.
	self background: (Color gray alpha: 0.1 ).
	self border: (BlBorder color: Color black width: 1 radius:5 style:(BlBorderStrokeStyle DOTTED)).
	self initializeHandlers.
	self initializeActions