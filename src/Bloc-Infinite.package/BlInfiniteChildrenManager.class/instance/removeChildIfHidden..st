children add/remove
removeChildIfHidden: aChildElement
	"Remove a child element from infinite element if it is hidden.
	Return true of child was found, hidden and was succesfully removed,
	false otherwise"
	<return: #Boolean>

	| index |
		
	index := controller childIndexOf: aChildElement.
	(index <= 0)
		ifTrue: [
			(self unhideChildInternal: aChildElement)
				ifTrue:  [ Error signal: 'Child is not in the element' ] ].

	(bucket get: index) ifTrue: [ 
		bucket remove: index.
		(self unhideChildInternal: aChildElement)
			ifFalse: [ Error signal: 'Child is not on hidden list' ].
		controller removeChildAt: index.
		^ true ].

	^ false