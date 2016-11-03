computing
calculateMaxIndex
	|result|
	result := -1.
	self element managedChildrenDo: [ :child |
		| spec span |
		spec := self specOf: child.
		span := spec span.
		result := result max: span first - 1.
		result := result max: span last - 1.
		result := result max: span size - 1 ].
	^ result = -1
		ifTrue: [ UNDEFINED ]
		ifFalse: [ result ]