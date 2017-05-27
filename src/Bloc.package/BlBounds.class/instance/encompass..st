rectangle functions
encompass: aPoint 
	"Inplace encompass me so that I contain both the receiver and aPoint."

	top := top min: aPoint y.
	right := right max: aPoint x.
	left := left min: aPoint x.
	bottom := bottom max: aPoint y