custom root
exampleSpaceRootIsAnElement
	| space |
	space := BlSpace new title: 'Root Element Example'.
	space
		root:
			(BlElement new
				background: (BlBackground paint: Color blue);
				yourself).
	space show