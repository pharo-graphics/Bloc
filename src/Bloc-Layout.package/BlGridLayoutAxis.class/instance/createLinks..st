computing links
createLinks: isMin
	<return: #'BlGridPackedMap<Interval, BlMutableInt>'>
		
	| links |
	links := OrderedCollection new.
	self groupBounds keysDo: [ :spec |
		| span |
		span := isMin
			ifTrue: [ spec span ]
			ifFalse: [ spec span inversed ].
		links add: (span -> BlGridMutableInteger new) ].
	^ BlGridPackedMap fromAssociations: links