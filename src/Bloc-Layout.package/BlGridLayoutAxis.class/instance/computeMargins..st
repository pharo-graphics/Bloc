computing margins
computeMargins: isLeading
	| margins |
	
	margins := isLeading
		ifTrue: [ leadingMargins ]
		ifFalse: [ trailingMargins ].

	self element managedChildrenDo: [ :child |
		child visibility shouldLayout ifTrue: [ 
			| spec span index margin |
			spec := self specOf: child.
			span := spec span.
			index := isLeading
				ifTrue: [ span first ]
				ifFalse: [ span last ].
			margin := (margins at: index) max: (self element layout measurer marginOf: child isHorizontal: self horizontal isLeading: isLeading).
			margins at: index put: margin ] ]