children - accessing
reverseChildrenDo: aBlock

	self childrenCount isZero
		ifTrue: [ ^ self ].

	self childrenCount to: 1 by: -1 do: [ :anIndex |
		aBlock cull: (self childAt: anIndex) cull: anIndex ]