computing weights
hasWeights

	hasWeightsValid ifFalse: [ 
		hasWeights := self computeHasWeights.
		hasWeightsValid := true ].
	^ hasWeights