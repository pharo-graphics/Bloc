operations
vLineTo
"
V (absolute) v (relative)

Draws a vertical line from the current point (cpx, cpy) to (cpx, y). V (uppercase) indicates that absolute coordinates will follow; v (lowercase) indicates that relative coordinates will follow. Multiple y values can be provided (although usually this doesn't make sense). At the end of the command, the new current point becomes (cpx, y) for the final value of y."

	| y |
	
	self skipBlanks.
	y := self nextNumber ifNil: [ ^ self error: 'number expected for horizontal line segment'   ].
	
	self vLineTo: y.
	
	[ self skipBlanks. y := self nextNumber. y notNil ] whileTrue: [
		self vLineTo: y
	].
