computing group bounds
createGroupBounds     
	<return: #'BlGridPackedMap<Interval, BlMutableInt>'>      
	|assocs|
	
	assocs := OrderedCollection new.
	self element managedChildrenDo: [ :child |
		| spec bounds |
		spec := self specOf: child.
		bounds := (spec absoluteAlignment: self horizontal) bounds.
		assocs add: (spec -> bounds) ].
	^ BlGridPackedMap fromAssociations: assocs