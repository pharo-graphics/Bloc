children accessing
childrenDo: aBlock

	1 to: self childrenCount do: [ :anIndex |
		aBlock value: (self childAt: anIndex) ]