private
fill: aPaint image: anImg outsets: anOutsets
	
	self
		assert: [ fill isNil and: [ image isNil and: [ outsets isNil ] ] ]
		description: [ 'I am immutable and can only be initialzed once!' ]. 

	fill := aPaint ifNil: [ Color transparent asBlPaint ].
	image := anImg.
	outsets := anOutsets ifNil: [ BlInsets empty ]