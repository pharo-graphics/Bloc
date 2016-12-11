animations
animateAppearance: anElementHolder preInfo: aPreInfoHolder postInfo: aPostInfoHolder
	
	anElementHolder isRecyclable: false.

	(itemAnimator
		animateAppearance: anElementHolder
		preLayoutInfo: aPreInfoHolder
		postLayoutInfo: aPostInfoHolder)
			ifTrue: [ self postAnimationRunner ]