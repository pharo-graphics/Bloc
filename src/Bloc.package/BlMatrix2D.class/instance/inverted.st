matrix - mathematical functions
inverted
	"Return a new instance of matrix which is an inverse of me.
	Throw BlSingularMatrixError if matrix is singular (non-invertible or degenerate)"
	<return: #BlMatrix2D>
	
	^ self copy inverse