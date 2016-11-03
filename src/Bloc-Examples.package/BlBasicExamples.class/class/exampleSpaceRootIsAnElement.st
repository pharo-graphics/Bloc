custom root
exampleSpaceRootIsAnElement
	| space |
	space := BlSpace new title: 'Root Element Example'.
	space
		root:
			(BlElement new
				background: (BlBackground fill: Color red);
				yourself).
	space show.