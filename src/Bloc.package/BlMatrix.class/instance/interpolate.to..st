matrix - mathematical functions
interpolate: aFactor to: anotherMatrix
	"Perform a matrix interpolation with a given factor"
	<return: #BlMatrix>
	
	^ (self decomposition
		interpolate: aFactor
		to: anotherMatrix decomposition) composition