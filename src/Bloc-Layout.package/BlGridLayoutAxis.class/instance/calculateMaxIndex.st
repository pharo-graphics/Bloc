computing
calculateMaxIndex
	|result|
	result := -1.
	self element children accountedByLayout withIndexDo: [ :child :index |
		| spec span |
		spec := (childConstraints at: index) spec.
		span := spec span.
		result := result max: span first.
		result := result max: span last.
		result := result max: span size - 1.
		result := result ].
	^ result < 0
		ifTrue: [ UNDEFINED ]
		ifFalse: [ result ]