example - composite
connectGrid: aLeftGridElement andGrid: aRightGridElement in: aContainerElement with: aLine1 with: aLine2 with: aLine3 with: aLine4 with: aLine5 with: aLine6
	<gtExample>
	<dependsOn: #shuffledGridColumn10:>
	<dependsOn: #shuffledGridColumn6:>
	<dependsOn: #container>
	<dependsOn: #grayLine:>
	<dependsOn: #grayLine:>
	<dependsOn: #grayLine:>
	<dependsOn: #grayLine:>
	<dependsOn: #grayLine:>
	<dependsOn: #grayLine:>
	| lines |

	lines := { 
		aLine1 . aLine2 . aLine3 . aLine4 . aLine5 . aLine6
	}.
	
	aLeftGridElement
		position: 50@55.
	
	aRightGridElement
		position: 500@45.
	
	lines withIndexDo: [ :aLine :anIndex |
		aLeftGridElement children
			detect: [ :aCellGrid | (aCellGrid userData at: #entity) = anIndex ]
			ifFound: [ :aLeftCell |
				aRightGridElement children
					detect: [ :aCellGrid | (aCellGrid userData at: #entity) = anIndex ]
				ifFound: [ :aRightCell |
					aLine
						fromAnchor: (BlGeometryAttachPointAnchor attachPoint: aLeftCell);
						toAnchor: (BlGeometryAttachPointAnchor attachPoint: aRightCell)
				] ] ].
	
	^ aContainerElement
		size: 600@600;
		addChild: aLeftGridElement;
		addChild: aRightGridElement;
		addChildren: lines;
		yourself