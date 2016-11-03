operations
lineTo
" 
L (absolute) l (relative)
lineto

(x y)+
Draw a line from the current point to the given (x,y) coordinate which becomes the new current point. L (uppercase) indicates that absolute coordinates will follow; l (lowercase) indicates that relative coordinates will follow. A number of coordinates pairs may be specified to draw a polyline. At the end of the command, the new current point is set to the final set of coordinates provided.
"

	| pt |
	pt := self readPoint.
	
	pt ifNil: [ self error: 'point expected for line segment' ].
	
	self lineTo: pt.
	
	[ pt := self readPoint. pt notNil ] whileTrue: [ self lineTo: pt ]