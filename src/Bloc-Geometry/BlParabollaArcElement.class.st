"
I represent an arc element that is rendered between two provided anchors and has configurable curvature, which can be absolute or relative (fraction)
"
Class {
	#name : #BlParabollaArcElement,
	#superclass : #BlCurveElement,
	#instVars : [
		'curvatureAnchor'
	],
	#category : 'Bloc-Geometry-Curves'
}

{ #category : #'anchor - geometry' }
BlParabollaArcElement >> anchorPositions [
	<return: #SequenceableCollection of: #Point>

	^ Array streamContents: [ :aStream |
		aStream nextPut: self fromPosition.
		aStream nextPutAll: self curvaturePositions.
		aStream nextPut: self toPosition ]
]

{ #category : #geometry }
BlParabollaArcElement >> curvature: aNumber [
	"Set an absolute curvature of the arc"

	self
		assert: [ curvatureAnchor isNotNil ]
		description: [ 'Via anchor must exist' ].

	self unregisterAnchor: curvatureAnchor.
	curvatureAnchor := (BlPerpendicularAnchor curvature: aNumber)
		referenceAnchors: { self fromAnchor . self toAnchor }.
	self registerAnchor: curvatureAnchor
]

{ #category : #'anchor - accessing' }
BlParabollaArcElement >> curvatureAnchor [
	<return: #BlGeometryAnchor>

	^ curvatureAnchor
]

{ #category : #geometry }
BlParabollaArcElement >> curvatureFraction: aNumber [
	"Set a relative fractional curvature of the arc"

	self
		assert: [ curvatureAnchor isNotNil ]
		description: [ 'Via anchor must exist' ].

	self unregisterAnchor: curvatureAnchor.
	curvatureAnchor := (BlPerpendicularFractionAnchor fraction: aNumber)
		referenceAnchors: { self fromAnchor . self toAnchor }.
	self registerAnchor: curvatureAnchor
]

{ #category : #'anchor - geometry' }
BlParabollaArcElement >> curvaturePositions [
	<return: #Collection of: #Point>

	self isSelfCurve
		ifTrue: [ ^ self fromAnchor selfPositionsWithin: self and: self toAnchor ].

	^ { self curvatureAnchor positionWithin: self }
]

{ #category : #'anchor - geometry' }
BlParabollaArcElement >> decoratedAnchorPositions [
	<return: #SequenceableCollection of: #Point>
	
	^ Array streamContents: [ :aStream |
		aStream nextPut: self decoratedFromPosition.
		aStream nextPutAll: self curvaturePositions.
		aStream nextPut: self decoratedToPosition ]
]

{ #category : #initialization }
BlParabollaArcElement >> defaultGeometry [
	^ BlBezierCurve new
]

{ #category : #initialization }
BlParabollaArcElement >> defaultViaAnchor [
	^ BlPerpendicularAnchor curvature: 50
]

{ #category : #drawing }
BlParabollaArcElement >> drawDebugInfoOnSpartaCanvas: aCanvas [
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
	
	
]

{ #category : #'anchor - accessing' }
BlParabollaArcElement >> fromAnchor: aBlGeometryAnchor [
	super fromAnchor: aBlGeometryAnchor.
	
	curvatureAnchor referenceAnchors: { self fromAnchor . self toAnchor }
]

{ #category : #'instance creation' }
BlParabollaArcElement >> fromDirection [
	"Return a vector representing a direction in which start of the curve is pointing"
	<return: #BlVector>

	^ (self fromPosition - self curvaturePositions first) asBlocVector
]

{ #category : #initialization }
BlParabollaArcElement >> initialize [
	super initialize.
	
	curvatureAnchor := self defaultViaAnchor referenceAnchors: { self fromAnchor . self toAnchor }
]

{ #category : #testing }
BlParabollaArcElement >> isSelfCurve [
	<return: #Boolean>
	
	^ self fromAnchor isSelfTo: self toAnchor
]

{ #category : #layout }
BlParabollaArcElement >> layoutBounds [
	<return: #Rectangle>
	
	^ Rectangle encompassing: self anchorPositions
]

{ #category : #layout }
BlParabollaArcElement >> measureGeometry [
	| theAnchorPositions aDelta |
	
	theAnchorPositions := self decoratedAnchorPositions.
	aDelta := self layoutBounds origin.

	self geometry controlPoints: (theAnchorPositions collect: [ :aPoint | aPoint - aDelta ])
]

{ #category : #'anchor - accessing' }
BlParabollaArcElement >> toAnchor: aBlGeometryAnchor [
	super toAnchor: aBlGeometryAnchor.

	curvatureAnchor referenceAnchors: { self fromAnchor . self toAnchor }
]

{ #category : #'instance creation' }
BlParabollaArcElement >> toDirection [
	"Return a vector representing a direction in which the end of the curve is pointing"
	<return: #BlVector>
	
	^ (self toPosition - self curvaturePositions last) asBlocVector
]
