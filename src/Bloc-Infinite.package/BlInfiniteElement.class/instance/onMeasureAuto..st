measurement
onMeasureAuto: anExtentMeasurementSpec
	| skipMeasure |

	skipMeasure := anExtentMeasurementSpec isExact.
	layout measure: self with: anExtentMeasurementSpec.
	skipMeasure
		ifTrue: [ ^ self ].

	self state isStartStep
		ifTrue: [ self dispatchLayoutFirstStep ].
	
	"set dimensions in 2nd step. Pre-layout should happen with old dimensions for consistency"
	layout measurementSpec: anExtentMeasurementSpec.
	self state isMeasuring: true.
	self dispatchLayoutSecondStep.
	
	"now we can get the width and height from the children"
	layout measureBasedOnChildren: anExtentMeasurementSpec.
	
	"if InfiniteElement has non-exact width and height and if there is at least one child
	which also has non-exact width & height, we have to re-measure."
	layout shouldMeasureTwice
		ifTrue: [ 
			layout measurementSpec: (BlExtentMeasurementSpec exact: self measuredExtent).
			self state isMeasuring: true.
			self dispatchLayoutSecondStep.
			"now we can get the width and height from the children."
			layout measureBasedOnChildren: anExtentMeasurementSpec ]