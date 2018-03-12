computing weights
computeHasWeights
	
	^ self element managedChildren anySatisfy: [ :child |
			child visibility shouldLayout
				and: [ (self specOf: child) weight isZero not ] ]