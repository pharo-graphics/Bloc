scheduling
unpostOnAnimation

	(BlUniverse default animationManager includesAnimation: self)
		ifTrue: [ BlUniverse default animationManager removeAnimation: self ]