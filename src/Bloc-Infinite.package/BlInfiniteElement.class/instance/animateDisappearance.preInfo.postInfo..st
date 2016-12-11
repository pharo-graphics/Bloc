animations
animateDisappearance: anElementHolder preInfo: aPreInfoHolder postInfo: aPostInfoHolder

	self addAnimatingChild: anElementHolder.
	anElementHolder isRecyclable: false.
	
	(itemAnimator
		animateDisappearance: anElementHolder
		preLayoutInfo: aPreInfoHolder
		postLayoutInfo: aPostInfoHolder)
			ifTrue: [ self postAnimationRunner ]