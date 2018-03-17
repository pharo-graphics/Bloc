computing group bounds
createGroupBounds     
	<return: #'BlGridPackedMap<Interval, BlMutableInt>'>      
	|assocs|
	
	assocs := OrderedCollection new.
	self element children accountedByLayout withIndexDo: [ :child :index |
		| spec bounds |
		spec := (childConstraints at: index) spec.
		bounds := (spec absoluteAlignment: self horizontal) bounds.
		assocs add: (spec -> bounds) ].
	^ BlGridPackedMap fromAssociations: assocs