api - bounds
boundsFor: aPath stroked: aStrokeOptions on: aCanvas within: anOutsirts
	<return: #Rectangle>

	self checkSession.

	(self hasCachedBounds
		and: [ self path == aPath
			and: [ self strokeOptions = aStrokeOptions
				and: [ self outskirts = anOutsirts ] ] ])
					ifTrue: [ ^ self bounds ].

	path := aPath.
	outskirts := anOutsirts.
	strokeOptions := aStrokeOptions.

	bounds := aPath strokedBoundsOn: aCanvas with: aStrokeOptions.

	^ bounds