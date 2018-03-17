computing weights
computeHasWeights
	
	^ self element children accountedByLayout anySatisfy: [ :child |
			child visibility shouldLayout
				and: [ (self specOf: child) weight isZero not ] ]