example - composite
connectGridWith12Lines
	<gtExample>
	| aGridElement anAttachPoint lines |

	aGridElement := self gridWith12Cells.
	anAttachPoint := self attachPoint.
	
	lines := 12 timesCollect: [ self grayLine ].
	
	aGridElement
		relocate: 50@50.
	
	anAttachPoint
		relocate: 500@400.
	
	lines with: aGridElement children do: [ :aLine :aGridCell |
		aLine
			fromAnchor: (BlElementCenterAnchor element: aGridCell);
			toAnchor: (BlElementCenterAnchor element: anAttachPoint) ].
	
	^ self container
		size: 600@600;
		addChild: anAttachPoint;
		addChild: aGridElement;
		addChildren: lines;
		yourself