commands
m
	"move-to relative"
	" 
		Start a new sub-path at the given (x,y) coordinate. M (uppercase) indicates that absolute coordinates will follow; m (lowercase) indicates that relative coordinates will follow. 
		If a relative moveto (m) appears as the first element of the path, then it is treated as a pair of absolute coordinates. 
		If a moveto is followed by multiple pairs of coordinates, the subsequent pairs are treated as implicit lineto commands.
	
	"
	| pt reset |

	pt := self readPoint.
	pt ifNil: [ self error: 'a point expected following after M/m command'].

	path isEmpty ifTrue: [ 
			self absolute; moveTo: pt; relative ] 
		ifFalse: [ self relative; moveTo: pt ].

	[ pt := self readPoint. pt notNil ] whileTrue: [ self lineTo: pt ]