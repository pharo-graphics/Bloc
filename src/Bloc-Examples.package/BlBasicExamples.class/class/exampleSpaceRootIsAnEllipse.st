custom root
exampleSpaceRootIsAnEllipse
	| space |
	space := BlSpace new
		title: 'Ellipse Shape example'.
	space root:
			((BlEllipse extent: 200 @ 100) asElement
				background: Color yellow;
				yourself).
	space show