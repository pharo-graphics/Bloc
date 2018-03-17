computing margins
computeMargins: isLeading
	| margins |
	
	margins := isLeading
		ifTrue: [ leadingMargins ]
		ifFalse: [ trailingMargins ].

	self element children accountedByLayout withIndexDo: [ :child :anIndex |
		child visibility shouldLayout ifTrue: [ 
			| spec span index margin |
			spec := (childConstraints at: anIndex) spec.
			span := spec span.
			index := isLeading
				ifTrue: [ span first ]
				ifFalse: [ span last ].
			margin := (margins at: index) max: (self layout measurer marginOf: child isHorizontal: self horizontal isLeading: isLeading).
			margins at: index put: margin ] ]