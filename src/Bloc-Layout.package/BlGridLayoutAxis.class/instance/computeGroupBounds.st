computing group bounds
computeGroupBounds

	groupBounds valuesDo: [ :bounds | bounds reset ].
	self element managedChildren withIndexDo: [ :child :index |
		| spec size |
		spec := (childConstraints at: index) spec.
		size := self layout measurer measurementWithMarginOf: child isHorizontal: self horizontal.
		size := size + (spec weight = 0
			ifTrue: [ 0 ]
			ifFalse: [ self deltas at: index ]).
		(groupBounds at: index) includeElement: self element spec: spec axis: self size: size ]