layout
layoutFrozen: aBoolean
	"Enable or disable layout and scroll.  After layoutFrozen is set to true,
	Layout requests will be postponed until layoutFrozen is set to false.
	Child elements are not updated when InfiniteElement is frozen"

	aBoolean = layoutFrozen
		ifTrue: [ ^ self ].
		
	self assertNotInLayoutOrScroll.

	aBoolean
		ifFalse: [ 
			layoutFrozen := false.
			layoutRequestEaten
				ifTrue: [ self requestLayout ].
			layoutRequestEaten := false ]
		ifTrue: [ 
			layoutFrozen := true.
			self stopScroll ]