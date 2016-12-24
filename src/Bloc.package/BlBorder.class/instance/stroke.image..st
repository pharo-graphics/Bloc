private
stroke: aBorderStroke image: aBorderImage

	self
		assert: [ stroke isNil and: [ image isNil ] ]
		description: [ 'I am immutable and can only be initialzed once!' ]. 

	stroke := aBorderStroke.
	image := aBorderImage.
	self computeInsetsOutsets