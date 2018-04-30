drawing
drawDebugInfoOnSpartaCanvas: aCanvas
	| theCurvaturePositions theFromToPositions theColors |
	
	super drawDebugInfoOnSpartaCanvas: aCanvas.
	
	theCurvaturePositions := self curvaturePositions collect: [ :aPoint | self parentPointToLocal: aPoint ].
	theCurvaturePositions size = 1
		ifTrue: [ theCurvaturePositions add: theCurvaturePositions first ].
	
	theFromToPositions := { self decoratedFromPosition . self decoratedToPosition } collect: [ :aPoint | self parentPointToLocal: aPoint ].
	
	theColors := { Color red. Color blue} as: Stack. 
	
	theFromToPositions with: theCurvaturePositions do: [ :anAnchorPoint :aCurvaturePoint |
		aCanvas stroke
			paint: theColors pop;
			width: 1;
			path: (aCanvas shape line: anAnchorPoint to: aCurvaturePoint);
			draw ]
	
	