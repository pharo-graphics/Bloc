transformations
scaleBy: aVector
	"Append a scaling transformation by a given vector"

	transformation addTransformation: ((BlScalingTransformation scale: aVector asScale3D) origin: origin)