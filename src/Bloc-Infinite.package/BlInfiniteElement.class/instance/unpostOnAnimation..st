deferred actions
unpostOnAnimation: aRunnableAction
	(BlUniverse default animationManager includesAnimation: aRunnableAction)
		ifTrue: [ BlUniverse default animationManager removeAnimation: aRunnableAction ]