children - accessing
childrenDo: aBlock

	1 to: self childrenCount do: [ :anIndex |
		aBlock cull: (self childAt: anIndex) cull: anIndex ]