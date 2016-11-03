computing arcs
createArcs
	|mins maxs n sMins sMaxs|
	mins := OrderedCollection new.
	maxs := OrderedCollection new.
	
	self addComponentSizesIn: mins links: self forwardLinks.
	self addComponentSizesIn: maxs links: self backwardLinks.
	
	self isOrderPreserved
		ifTrue: [ 
			1 to: self count do: [ :i |
				self includeIn: mins span: (i to: i + 1) size: (BlGridMutableInteger value: 0) ] ].
		
	n := self count.
	self includeIn: mins span: (1 to: n + 1) size: parentMin ignoreIfPresent: false.
	self includeIn: maxs span: (n + 1 to: 1) size: parentMax ignoreIfPresent: false.
	
	sMins := self topologicalSort: mins.
	sMaxs := self topologicalSort: maxs.
	
	^ sMins, sMaxs