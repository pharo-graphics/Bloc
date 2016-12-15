manager -> element
removeChildAt: anIndex
	| anElement |
	anElement := infiniteElement children 
		at: anIndex
		ifAbsent: [ ^ self ].

	infiniteElement dispatchChildDetached: anElement.
	infiniteElement removeChildAt: anIndex