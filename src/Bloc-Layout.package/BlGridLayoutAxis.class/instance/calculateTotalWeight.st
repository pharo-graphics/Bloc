computing weights
calculateTotalWeight

	^ (self element children accountedByLayout inject: 0.0 into: [ :totalWeight :child |
		child visibility shouldLayout
			ifTrue: [ totalWeight + (self specOf: child) weight ]
			ifFalse: [ totalWeight  ] ]) asFloat