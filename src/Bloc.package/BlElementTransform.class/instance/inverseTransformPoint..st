bounds
inverseTransformPoint: aPoint
	"Apply an inversed transformation on a given point and return a result.
	Note: Throws BlSingularMatrixError if underlying matrix is singular"

	<return: #Point>
	aPoint isPoint
		ifFalse: [ self error: 'Only points can be transformed!' ].
	self ensureMatrix.
	^ matrix inverted transformPoint: aPoint