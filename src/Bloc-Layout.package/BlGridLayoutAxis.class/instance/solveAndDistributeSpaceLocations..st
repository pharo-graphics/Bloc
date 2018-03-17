computing inequalities
solveAndDistributeSpaceLocations: theLocations
	| deltaMax deltaMin totalWeight validDelta validSolution |
	self deltas atAllPut: 0.
	self solveLocations: theLocations.
	
	deltaMax := (parentMin value * self element children accountedByLayout size) asFloat.
	deltaMax < 1
		ifTrue: [ ^ self ].

	deltaMin := 0.
	totalWeight := self calculateTotalWeight.
	validDelta := -1.
	validSolution := true.
	[ ((deltaMax - deltaMin)) > 0.0001 ] whileTrue: [ 
		| delta |
		delta := (deltaMin / 2.0) + (deltaMax / 2.0).
		self invalidateValues.
		self shareOutDelta: delta totalWeight: totalWeight.
		validSolution := self solve: self arcs locations: theLocations modifyOnError: false.
		validSolution
			ifTrue: [ 
				validDelta := delta.
				deltaMin := delta + 1.0 ]
			ifFalse: [ deltaMax := delta ] ].
	
	(validDelta > 0 and: [ validSolution not ]) ifTrue: [ 
		self invalidateValues.
		self shareOutDelta: validDelta totalWeight: totalWeight.
		self solveLocations: theLocations ]