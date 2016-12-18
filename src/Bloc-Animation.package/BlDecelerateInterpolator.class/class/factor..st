instance creation
factor: aNumber
	"Creates an instance of decelerate interpolator with custom factor number"
	<return: #BlDecelerateInterpolator>

	^ self basicNew
		initializeWith: aNumber;
		yourself