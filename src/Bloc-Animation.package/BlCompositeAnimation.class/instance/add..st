adding
add: anAnimation
	anAnimation parent: self.
	children add: anAnimation.
	self computeDuration.