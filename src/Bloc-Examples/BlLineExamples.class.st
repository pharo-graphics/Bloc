"
I contain examples and a few usecases of ===BlLineElement===
"
Class {
	#name : #BlLineExamples,
	#superclass : #BlGeometryElementExamples,
	#category : #'Bloc-Examples-Geometry'
}

{ #category : #examples }
BlLineExamples class >> connectGridAndAttachPoint [
	<script: 'self connectGridAndAttachPoint'>

	self
		openInWindow: self new connectGridWith12Lines
		named: 'Grid and point'
		extent: 600@500
]

{ #category : #examples }
BlLineExamples class >> connectTwoGrids [
	<script: 'self connectTwoGrids'>

	self
		openInWindow: self new connectTwoGridsWith6Lines
		named: 'Two grids'
		extent: 600@600
]

{ #category : #examples }
BlLineExamples class >> lineBetweenElementBottomCenters [
	<script: 'self lineBetweenElementBottomCenters'>

	self
		openInWindow: self new lineBetweenElementBottomCenters
		named: 'Connected bottom centers'
		extent: 500@500
]

{ #category : #examples }
BlLineExamples class >> lineBetweenElementCenters [
	<script: 'self lineBetweenElementCenters'>

	self
		openInWindow: self new lineBetweenElementCenters
		named: 'Connected centers'
		extent: 500@500
]

{ #category : #examples }
BlLineExamples class >> lineBetweenSubElements [
	<script: 'self lineBetweenSubElements'>

	self
		openInWindow: self new lineBetweenSubElements
		named: 'Connected sub-elements'
		extent: 500@500
]

{ #category : #examples }
BlLineExamples class >> lineWithAnchors [
	<script: 'self lineWithAnchors'>

	self
		openInWindow: self new lineWithAnchors
		named: 'Line and anchors'
		extent: 520@480
]

{ #category : #examples }
BlLineExamples class >> lineWithNearestBoundsAnchors [
	<script: 'self lineWithNearestBoundsAnchors'>

	self
		openInWindow: self new lineWithNearestBoundsAnchors
		named: 'Line with nearest bounds anchors'
		extent: 600@550
]

{ #category : #examples }
BlLineExamples class >> lineWithNearestCircleAnchors [
	<script: 'self lineWithNearestCircleAnchors'>

	self
		openInWindow: self new lineWithNearestCircleAnchors
		named: 'Line with nearest circle anchors'
		extent: 600@550
]

{ #category : #examples }
BlLineExamples class >> twoLines [
	<script: 'self twoLines'>

	self
		openInWindow: self new twoLines
		named: 'Two lines'
		extent: 620@600
]

{ #category : #'example - visual properties' }
BlLineExamples >> blueLine [
	<gtExample>

	^ self line border: (BlBorder paint: Color blue width: 2)
]

{ #category : #'instance creation' }
BlLineExamples >> box [
	<gtExample>
	
	^ BlElement new
		size: 100@100;
		background: (Color gray alpha: 0.3);
		border: (BlBorder builder width: 1; paint: Color gray; build);
		layout: BlFrameLayout new;
		addEventHandler: BlPullHandler new;
		yourself.
]

{ #category : #'instance creation' }
BlLineExamples >> circleAttachPoint [
	<gtExample>	

	^ BlElement new
		geometry: BlEllipse new;
		size: 75@75;
		background: (Color blue alpha: 0.3);
		border: BlBorder empty;
		addEventHandler: BlPullHandler new
]

{ #category : #'example - composite' }
BlLineExamples >> connectGridWith12Lines [
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
]

{ #category : #'example - composite' }
BlLineExamples >> connectTwoGridsWith6Lines [
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
]

{ #category : #'example - visual properties' }
BlLineExamples >> grayLine [
	<gtExample>

	^ self line border: (BlBorder paint: Color darkGray width: 0.25)
]

{ #category : #'instance creation' }
BlLineExamples >> grid [
	<gtExample>
	
	^ BlElement new
		background: Color veryVeryLightGray;
		layout: (BlGridLayout vertical cellSpacing: 10);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		yourself
]

{ #category : #'instance creation' }
BlLineExamples >> gridCell [
	<gtExample>
	
	^ BlTextElement new
		background: Color veryLightGray;
		padding: (BlInsets all: 10);
		constraintsDo: [ :c |
			c grid horizontal alignCenter.
			c grid vertical alignCenter ];
		yourself
]

{ #category : #'example - grid' }
BlLineExamples >> gridColumnWith10Cells [
	<gtExample>

	^ self gridColumnWith: 10
]

{ #category : #'example - grid' }
BlLineExamples >> gridColumnWith6Cells [
	<gtExample>

	^ self gridColumnWith: 6
]

{ #category : #'example - grid' }
BlLineExamples >> gridColumnWith: aNumberOfCells [
	<gtExample>
	| cells |

	cells := (1 to: aNumberOfCells) collect: [ :i | self gridCell ].

	cells withIndexDo: [ :aCell :anIndex |
		aCell userData at: #entity put: anIndex.
		aCell text: (BlRopedText string: anIndex asString) ].
	
	^ self grid
		layoutDo: [ :aGridLayout | aGridLayout columnCount: 1 ];
		addChildren: cells;
		yourself
]

{ #category : #'example - grid' }
BlLineExamples >> gridWith12Cells [
	<gtExample>
	| cells |

	cells := (1 to: 12) collect: [ :i | self gridCell ].

	cells withIndexDo: [ :aCell :anIndex |
		aCell userData at: #entity put: anIndex.
		aCell text: (BlRopedText string: anIndex asString) ].
	
	^ self grid
		layoutDo: [ :aGridLayout | aGridLayout rowCount: 4 ];
		addChildren: cells;
		yourself
]

{ #category : #'instance creation' }
BlLineExamples >> line [
	<gtExample>
	
	^ BlLineElement new
		zIndex: 10;
		yourself
]

{ #category : #'example - connections' }
BlLineExamples >> lineBetweenElementBottomCenters [
	<gtExample>
	| redLine fromBox toBox |
	
	fromBox := self box.
	fromBox relocate: 50@50.
	
	toBox := self box.
	toBox relocate: 250@250.
	
	redLine := self redLine.
	
	redLine fromAnchor: (BlElementBottomCenterAnchor element: fromBox).
	redLine toAnchor: (BlElementBottomCenterAnchor element: toBox).
	
	^ self container
		addChildren: { fromBox . toBox . redLine }
]

{ #category : #'example - connections' }
BlLineExamples >> lineBetweenElementCenters [
	<gtExample>
	| redLine fromBox toBox |
	
	fromBox := self box.
	fromBox relocate: 50@50.
	
	toBox := self box.
	toBox relocate: 250@250.
	
	redLine := self redLine.
	
	redLine fromAnchor: (BlElementCenterAnchor element: fromBox).
	redLine toAnchor: (BlElementCenterAnchor element: toBox).
	
	^ self container
		addChildren: { fromBox . toBox . redLine }
]

{ #category : #'example - connections' }
BlLineExamples >> lineBetweenSubElements [
	<gtExample>
	| attachFrom attachTo fromBox toBox  redLine |
	
	attachFrom := self attachPoint.
	attachFrom
		constraintsDo: [ :c |
			c frame horizontal alignRight.
			c frame vertical alignCenter ].
		
	attachTo := self attachPoint.
	attachTo
		constraintsDo: [ :c |
			c frame horizontal alignLeft.
			c frame vertical alignBottom ].
		
	fromBox := self box.
	fromBox relocate: 50@50.
	fromBox addChild: attachFrom.
	
	toBox := self box.
	toBox relocate: 250@250.
	toBox addChild: attachTo.
	
	redLine := self redLine.
	
	redLine fromAnchor: (BlElementCenterAnchor element: attachFrom).
	redLine toAnchor: (BlElementCenterAnchor element: attachTo).
	
	^ self container
		addChildren: { fromBox . toBox . redLine }
]

{ #category : #'example - connections' }
BlLineExamples >> lineWithAnchors [
	<gtExample>	
	| redLine attachFrom attachTo |
	
	redLine := self redLine.
	
	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 400 @ 300.

	redLine fromAnchor: (BlElementCenterAnchor element: attachFrom).
	redLine toAnchor: (BlElementCenterAnchor element: attachTo).


	^ self container
		addChildren: { redLine . attachFrom . attachTo }
]

{ #category : #'example - connections' }
BlLineExamples >> lineWithNearestBoundsAnchors [
	<gtExample>
	| redLine attachFrom attachTo |

	redLine := self redLine.

	attachFrom := self rectangleAttachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self rectangleAttachPoint.
	attachTo relocate: 400 @ 300.

	redLine fromAnchor: (BlNearestPositionBoundsAnchor nearestTo: attachTo from: attachFrom).
	redLine toAnchor: (BlNearestPositionBoundsAnchor nearestTo: attachFrom from: attachTo).

	^ self container
		addChildren: { redLine . attachFrom . attachTo }
]

{ #category : #'example - connections' }
BlLineExamples >> lineWithNearestCircleAnchors [
	<gtExample>
	| redLine attachFrom attachTo |

	redLine := self redLine.

	attachFrom := self circleAttachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self circleAttachPoint.
	attachTo relocate: 400 @ 300.

	redLine fromAnchor: (BlNearestPositionTightCircleAnchor nearestTo: attachTo from: attachFrom).
	redLine toAnchor: (BlNearestPositionTightCircleAnchor nearestTo: attachFrom from: attachTo).

	^ self container
		addChildren: { redLine . attachFrom . attachTo }
]

{ #category : #'instance creation' }
BlLineExamples >> rectangleAttachPoint [
	<gtExample>	

	^ BlElement new
		size: 75@75;
		background: (Color blue alpha: 0.3);
		border: BlBorder empty;
		addEventHandler: BlPullHandler new
]

{ #category : #'example - visual properties' }
BlLineExamples >> redLine [
	<gtExample>

	^ self line border: (BlBorder paint: Color red width: 2)
]

{ #category : #'example - connections' }
BlLineExamples >> twoLines [
	<gtExample>
	
	| redLine blueLine attachPoint |
	
	redLine := self redLine.
	blueLine := self blueLine.
	
	attachPoint := self attachPoint.
	attachPoint relocate: 400 @ 200.

	redLine fromAnchor: (BlAbsolutePositionAnchor position: 100 @ 100).
	redLine toAnchor: (BlElementCenterAnchor element: attachPoint).
	
	blueLine fromAnchor: (BlElementCenterAnchor element: attachPoint).
	blueLine toAnchor: (BlAbsolutePositionAnchor position: 500 @ 500).

	^ self container
		addChildren: { redLine . blueLine . attachPoint }
]
