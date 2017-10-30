accessing
center
	"Return a point representing a geometrical center of this bounds"
	<return: #Point>
	
	^ self position + (self extent / 2.0)