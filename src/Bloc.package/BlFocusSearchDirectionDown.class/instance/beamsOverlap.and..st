testing
beamsOverlap: aBlBounds and: anotherBlBounds
	<return: #Boolean>
	
	^ anotherBlBounds right >= aBlBounds left
		and: [ anotherBlBounds left <= aBlBounds right ]