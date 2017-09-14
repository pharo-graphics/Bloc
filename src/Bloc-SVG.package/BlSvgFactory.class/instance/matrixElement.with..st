transformations
matrixElement: aBlElement with: anOrderedCollection
	|matrix|
	matrix := BlMatrix2D new x: (anOrderedCollection at:5)
									y: (anOrderedCollection at:6)
									sx: (anOrderedCollection at:1)
									sy: (anOrderedCollection at:4)
									shx: (anOrderedCollection at:3)
									shy: (anOrderedCollection at:2).
	
	aBlElement transformWithMatrix2D: matrix.