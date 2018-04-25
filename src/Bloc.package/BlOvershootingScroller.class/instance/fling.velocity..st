api - scrolling
fling: aStartPosition velocity: aVelocityPoint

	self
		fling: aStartPosition
		velocity: aVelocityPoint
		min: Float negativeInfinity @ Float negativeInfinity
		max: Float infinity @ Float infinity
		overshot: 0@0