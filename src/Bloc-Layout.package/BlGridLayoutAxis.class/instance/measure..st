measure
measure: aMeasurementSpec
	| mode size |
	mode := aMeasurementSpec mode.
	size := aMeasurementSpec size.
	
	mode isUnspecified
		ifTrue: [ ^ self measureMin: 0 max: Float infinity ].

	mode isExact
		ifTrue: [ ^ self measureMin: size max: size ].

	mode isAtMost
		ifTrue: [ ^ self measureMin: 0 max: size ].
	
	Warning signal: 'Unknown measurement spec mode: ', mode asString.
	
	^ 0