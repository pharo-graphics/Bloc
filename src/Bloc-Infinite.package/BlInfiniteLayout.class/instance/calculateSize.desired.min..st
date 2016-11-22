private - measurement
calculateSize: aMeasurementSpec desired: aDesiredSize min: aMinSize
	"Calculates a size from the given measurement specs and parameters
	that is closest to the desired size and also complies with the spec"
	<return: #Number>

	aMeasurementSpec isExact
		ifTrue: [ ^ aMeasurementSpec size ].
	
	aMeasurementSpec isAtMost
		ifTrue: [ ^ aMeasurementSpec size min: (aDesiredSize max: aMinSize) ].
	
	"Unspecified and the rest of types if any"
	^ aDesiredSize max: aMinSize