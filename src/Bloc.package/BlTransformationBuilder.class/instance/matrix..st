transformations
matrix: aMatrix
	"Note: matrix transformation is not influenced by origin (it is always top left corner or 0@0)"
	transformation addTransformation: ((BlMatrixTransformation matrix: aMatrix) origin: BlAffineTransformationTopLeftOrigin new)