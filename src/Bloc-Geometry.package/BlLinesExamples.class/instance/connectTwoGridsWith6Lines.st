example - composite
connectTwoGridsWith6Lines
	<gtExample>
	| lines aLeftGridElement aRightGridElement |

	lines := (1 to: 6) collect: [ :i | self grayLine ].
	
	aLeftGridElement := self shuffledGridColumnWith10Cells.
	aRightGridElement := self shuffledGridColumnWith6Cells.
	
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