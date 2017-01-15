rendering
prepareForDrawing
	self hasResized
		ifTrue: [ self resized ].
	self makeCurrent.
	SDL2 glClear: 16384