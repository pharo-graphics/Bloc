removing
removeAllChildren
	
	1 to: self childrenCount do: [ :anIndex |
		| anElement |
		anElement := self childAt: anIndex.
		infiniteElement dispatchChildDetached: anElement ].
	
	infiniteElement removeAllChildren