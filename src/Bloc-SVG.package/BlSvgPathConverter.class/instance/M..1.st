path commands
M
	"move-to absolute"
	" 
		Start a new sub-path at the given (x,y) coordinate. M (uppercase) indicates that absolute coordinates will follow; m (lowercase) indicates that relative coordinates will follow. 
		If a relative moveto (m) appears as the first element of the path, then it is treated as a pair of absolute coordinates. 
		If a moveto is followed by multiple pairs of coordinates, the subsequent pairs are treated as implicit lineto commands.
	
	"
	self absolute; moveTo.
