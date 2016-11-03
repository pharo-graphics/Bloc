computing arcs
arcs

	arcs
		ifNil: [ arcs := self createArcs ].
		
	arcsValid ifFalse: [ 
		self computeArcs.
		arcsValid := true ].
	
	^ arcs