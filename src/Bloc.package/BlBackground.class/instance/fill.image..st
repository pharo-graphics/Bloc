private
fill: aPaint image: anImg
	
	self
		assert: [ fill isNil and: [ image isNil ] ]
		description: [ 'I am immutable and can only be initialzed once!' ]. 

	fill := aPaint ifNil: [ BlPaint transparent ].
	image := anImg