animations
animateChangeFrom: anOldElementHolder to: aNewElementHolder preInfo: aPreInfoHolder postInfo: aPostInfoHolder oldHolderDisappearing: oldHolderDisappearing newHolderDisappearing: newHolderDisappearing

	anOldElementHolder isRecyclable: false.
	oldHolderDisappearing
		ifTrue: [ self addAnimatingChild: anOldElementHolder ].
	
	(anOldElementHolder ~~ aNewElementHolder)
		ifTrue: [ 
			newHolderDisappearing
				ifTrue: [ self addAnimatingChild: aNewElementHolder ].
			anOldElementHolder shadowedHolder: aNewElementHolder.
			"old holder should disappear after animation ends"
			self addAnimatingChild: anOldElementHolder.
			recycler unscrapHolder: anOldElementHolder.
			aNewElementHolder isRecyclable: false.
			aNewElementHolder shadowingHolder: anOldElementHolder ].
	
	(itemAnimator
		animateChange: aNewElementHolder
		previousHolder: anOldElementHolder
		preLayoutInfo: aPreInfoHolder
		postLayoutInfo: aPostInfoHolder)
			ifTrue: [ self postAnimationRunner ]