scrolling
flingBy: aVelocityPoint

	infiniteElement scrollState: ScrollSettling.
	lastFlingX := 0.
	lastFlingY := 0.
	scroller
		fling: 0@0
		velocity: aVelocityPoint
		min: Float negativeInfinity @ Float negativeInfinity
		max: Float infinity @ Float infinity.
	
	self postOnAnimation