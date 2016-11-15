children add/remove
removeChildIfHidden: child
	| index |
		
	index := controller childIndexOf: child.
	(index <= 0)
		ifTrue: [
			(self unhideChildInternal: child)
				ifTrue:  [ Error signal: 'Child is not in the element' ] ].

	(bucket get: index) ifTrue: [ 
		bucket remove: index.
		(self unhideChildInternal: child)
			ifFalse: [ Error signal: 'Child is not on hidden list' ].
		controller removeChildAt: index.
		^ true ].

	^ false