processing
processPersistent: anElementHolder preInfo: aPreInfoHolder postInfo: aPostInfoHolder

	anElementHolder isRecyclable: false.
	(infiniteElement isDataSourceChangedAfterLayout)
		ifTrue: [ 
			"since it was rebound, use change instead as we'll be mapping them from stable ids.
			If stable ids were false, we would not be running any animations"
			(infiniteElement itemAnimator
				animateChange: anElementHolder
				previousHolder: anElementHolder
				preLayoutInfo: aPreInfoHolder
				postLayoutInfo: aPostInfoHolder)
					ifTrue: [ infiniteElement postAnimationRunner ] ]
		ifFalse: [ 
			(infiniteElement itemAnimator
				animatePersistence: anElementHolder
				preLayoutInfo: aPreInfoHolder
				postLayoutInfo: aPostInfoHolder)
					ifTrue: [ infiniteElement postAnimationRunner ] ]