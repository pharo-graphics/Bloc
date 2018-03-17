example - composite
connectTwoGridsWith6Lines
	<gtExample>
	| lines aLeftGridElement aRightGridElement |

	lines := 6 timesCollect: [ self grayLine ].
	
	aLeftGridElement := self gridColumnWith10Cells.
	aRightGridElement := self gridColumnWith6Cells.
	
	aLeftGridElement
		relocate: 50@55.
	
	aRightGridElement
		relocate: 500@45.
	
	lines withIndexDo: [ :aLine :anIndex |
		aLeftGridElement children
			detect: [ :aCellGrid | (aCellGrid userData at: #entity) = anIndex ]
			ifFound: [ :aLeftCell |
				aRightGridElement children
					detect: [ :aCellGrid | (aCellGrid userData at: #entity) = anIndex ]
				ifFound: [ :aRightCell |
					aLine
						fromAnchor: (BlElementCenterAnchor element: aLeftCell);
						toAnchor: (BlElementCenterAnchor element: aRightCell)
				] ] ].
	
	^ self container
		size: 600@600;
		addChild: aLeftGridElement;
		addChild: aRightGridElement;
		addChildren: lines;
		yourself