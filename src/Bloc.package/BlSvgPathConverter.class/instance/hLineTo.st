operations
hLineTo
"
H (absolute) h (relative)

x +
Draws a horizontal line from the current point (cpx, cpy) to (x, cpy). H (uppercase) indicates that absolute coordinates will follow; h (lowercase) indicates that relative coordinates will follow. Multiple x values can be provided (although usually this doesn't make sense). At the end of the command, the new current point becomes (x, cpy) for the final value of x.
"

	| x |
	
	self skipBlanks.
	x := self nextNumber ifNil: [ ^ self error: 'number expected for horizontal line segment'   ].
	
	self hLineTo: x.
	
	[ self skipBlanks. x := self nextNumber. x notNil ] whileTrue: [
		self hLineTo: x
	].
