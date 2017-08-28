example - composite
connectGrid: aGridElement and: anAttachPoint in: aContainerElement with: aLine1 with: aLine2 with: aLine3 with: aLine4 with: aLine5 with: aLine6 with: aLine7 with: aLine8 with: aLine9 with: aLine10 with: aLine11 with: aLine12
	<gtExample>
	<dependsOn: #grid:with:with:with:with:with:with:with:with:with:with:with:with:>
	<dependsOn: #attachPoint>
	<dependsOn: #container>
	<dependsOn: #grayLine:>
	<dependsOn: #grayLine:>
	<dependsOn: #grayLine:>
	<dependsOn: #grayLine:>
	<dependsOn: #grayLine:>
	<dependsOn: #grayLine:>
	<dependsOn: #grayLine:>
	<dependsOn: #grayLine:>
	<dependsOn: #grayLine:>
	<dependsOn: #grayLine:>
	<dependsOn: #grayLine:>
	<dependsOn: #grayLine:>
	| lines |

	lines := { 
		aLine1 . aLine2 . aLine3 . aLine4 . aLine5.
		aLine6 . aLine7 . aLine8 . aLine9. aLine10.
		aLine11. aLine12.
	}.
	
	aGridElement
		position: 50@50.
	
	anAttachPoint
		position: 500@400.
	
	lines with: aGridElement children do: [ :aLine :aGridCell |
		aLine
			fromAnchor: (BlElementRelativeAnchor attachPoint: aGridCell);
			toAnchor: (BlElementRelativeAnchor attachPoint: anAttachPoint) ].
	
	^ aContainerElement
		size: 600@600;
		addChild: anAttachPoint;
		addChild: aGridElement;
		addChildren: lines;
		yourself