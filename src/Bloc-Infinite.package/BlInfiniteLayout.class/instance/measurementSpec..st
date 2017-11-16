initialization
measurementSpec: anExtentMeasurementSpec
	"Update measurement specifications. I am sent from onMeasure: by infinite element.
	anExtentMeasurementSpec must not be nil"
	self
		assert: [ anExtentMeasurementSpec isNotNil ]
		description: [ 'Measurement specification must not be nil' ].
	
	widthSpec := anExtentMeasurementSpec widthSpec.
	heightSpec := anExtentMeasurementSpec heightSpec.

	width := widthSpec isUnspecified
		ifTrue: [ 0 ]
		ifFalse: [ widthSpec size ].
		
	width := width min: self maximumWidth.
		
	height := heightSpec isUnspecified
		ifTrue: [ 0 ]
		ifFalse: [ heightSpec size ].
		
	height := height min: self maximumHeight