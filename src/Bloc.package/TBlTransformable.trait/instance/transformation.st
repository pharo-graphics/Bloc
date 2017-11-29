transformations
transformation
	"Return an object that represents a description of my transformation.
	It can either be a local transformation being a composition of affine transformations or
	and absolute transformation directly defined with matrix"
	<return: #BlElementTransformation>

	^ self explicitRequirement