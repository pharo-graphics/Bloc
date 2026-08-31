"
An AkGroupTest is a test class for testing the behavior of AkGroup
"
Class {
	#name : #BlGeometryTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests-Geometry'
}

{ #category : #testing }
BlGeometryTest class >> shouldInheritSelectors [
	^ true
	
]

{ #category : #'contains tests' }
BlGeometryTest >> test3ElContainsPoint [

	| g c1 c2 |
	c1 := BlElement new
		      extent: 200 @ 100;
		      position: 100 @ 100;
		      background: Color yellow;
		      yourself.

	c2 := BlElement new
		      extent: 400 @ 300;
		      position: 100 @ 100;
		      background: Color red;
		      addChild: c1;
		      yourself.

	g := BlElement new
		     extent: 700 @ 500;
		     position: 0 @ 0;
		     background: Color blue;
		     addChild: c2;
		     yourself.

	g forceLayout.

	self assert: (c1 containsGlobalPoint: 250 @ 250).
	self assert: (c2 containsGlobalPoint: 250 @ 250).
	self assert: (g containsGlobalPoint: 250 @ 250).

	self assert: (c1 containsPoint: 50 @ 50)
]

{ #category : #'any bounds tests' }
BlGeometryTest >> testElAnyBounds [

	| g c1 c2 |
	c1 := BlElement new
		      extent: 200 @ 100;
		      position: 100 @ 100;
		      yourself.
	c2 := BlElement new
		      extent: 400 @ 300;
		      position: 100 @ 100;
		      addChild: c1;
		      yourself.
	g := BlElement new
		     extent: 700 @ 500;
		     position: 0 @ 0;
		     addChild: c2;
		     yourself.

	g forceLayout.

	self assert: g positionInSpace equals: 0 @ 0.
	self assert: c2 positionInSpace equals: 100 @ 100.
	self assert: c1 positionInSpace equals: 200 @ 200.

	self
		assert: g geometryBoundsInSpace
		equals: (0 @ 0 corner: 700 @ 500).
	self assert: c2 geometryBounds equals: (0 @ 0 corner: 400 @ 300).
	self assert: c1 geometryBounds equals: (0 @ 0 corner: 200 @ 100).

	self assert: g effectBounds equals: (0 @ 0 corner: 700 @ 500).
	self assert: c2 effectBounds equals: (0 @ 0 corner: 400 @ 300).
	self assert: c1 effectBounds equals: (0 @ 0 corner: 200 @ 100).

	self assert: g boundsInLocal equals: (0 @ 0 corner: 700 @ 500).
	self assert: c2 boundsInLocal equals: (0 @ 0 corner: 400 @ 300).
	self assert: c1 boundsInLocal equals: (0 @ 0 corner: 200 @ 100).

	self
		assert: g bounds inParent asRectangle
		equals: (0 @ 0 corner: 700 @ 500).
	self
		assert: c2 bounds inParent asRectangle
		equals: (100 @ 100 corner: 500 @ 400).
	self
		assert: c1 bounds inParent asRectangle
		equals: (100 @ 100 corner: 300 @ 200).

	self assert: g transformedBounds equals: (0 @ 0 corner: 700 @ 500).
	self assert: c2 transformedBounds equals: (0 @ 0 corner: 400 @ 300).
	self assert: c1 transformedBounds equals: (0 @ 0 corner: 200 @ 100).

	self
		assert: g geometryBoundsInSpace
		equals: (0 @ 0 corner: 700 @ 500).
	self
		assert: c2 geometryBoundsInSpace
		equals: (100 @ 100 corner: 500 @ 400).
	self
		assert: c1 geometryBoundsInSpace
		equals: (200 @ 200 corner: 400 @ 300)
]

{ #category : #'bounds tests' }
BlGeometryTest >> testElLocalAndGlobalBoundsConvertion [

	| g |
	g := BlElement new
		     extent: 100 @ 100;
		     position: 10 @ 10;
		     yourself.

	g forceLayout.

	self assert: g position equals: 10 @ 10.
	self assert: g geometryBounds equals: (0 @ 0 corner: 100 @ 100).
	self
		assert: g geometryBoundsInSpace asRectangle
		equals: (10 @ 10 corner: 110 @ 110).

	self
		assert:
			(g globalBoundsToLocal:
				 (BlBounds origin: 10 @ 10 corner: 110 @ 110)) asRectangle
		equals: g geometryBounds asRectangle.
	"is the same as"
	self
		assert:
			(g localBoundsToGlobal: (BlBounds fromRectangle: g geometryBounds))
				asRectangle
		equals: (10 @ 10 corner: 110 @ 110)
]

{ #category : #'position tests' }
BlGeometryTest >> testElLocalAndGlobalPostionConvertion [

	| g n |
	n := BlElement new
		     extent: 100 @ 100;
		     position: 10 @ 10;
		     yourself.

	g := BlElement new
		     extent: 100 @ 100;
		     position: 10 @ 10;
		     addChild: n;
		     yourself.

	g forceLayout.

	self assert: g position equals: 10 @ 10.
	self assert: n position equals: 10 @ 10.
	self assert: g positionInSpace equals: 10 @ 10.
	self assert: n positionInSpace equals: 20 @ 20.
	self assert: (n parentPointToLocal: n position) equals: 0 @ 0
]

{ #category : #'tx bounds tests' }
BlGeometryTest >> testElTxBounds [

	| g n |
	n := BlElement new
		     extent: 100 @ 100;
		     position: 10 @ 10;
		     yourself.
	g := BlElement new
		     extent: 100 @ 100;
		     position: 10 @ 10;
		     addChild: n;
		     yourself.

	g forceLayout.

	self assert: g position equals: (10 @ 10).
	self assert: n position equals: (10 @ 10).
	self assert: g positionInSpace equals: (10 @ 10).
	self assert: n positionInSpace equals: (20 @ 20).
	self assert: n transformedBounds equals: (0 @ 0 corner: 100 @ 100).
	self assert: g transformedBounds equals: (0 @ 0 corner: 100 @ 100)
]

{ #category : #tests }
BlGeometryTest >> testEqualityBlAnnulusSectorGeometry [

	self
		assert: (BlAnnulusSectorGeometry new
				 startAngle: 0;
				 endAngle: 90;
				 innerRadius: 0.5;
				 outerRadius: 1.0)
		equals: (BlAnnulusSectorGeometry new
				 startAngle: 0;
				 endAngle: 90;
				 innerRadius: 0.5;
				 outerRadius: 1.0).
	self
		deny: (BlAnnulusSectorGeometry new
				 startAngle: 10;
				 endAngle: 90;
				 innerRadius: 0.5;
				 outerRadius: 1.0)
		equals: (BlAnnulusSectorGeometry new
				 startAngle: 0;
				 endAngle: 90;
				 innerRadius: 0.5;
				 outerRadius: 1.0).
	self
		deny: (BlAnnulusSectorGeometry new
				 startAngle: 0;
				 endAngle: 80;
				 innerRadius: 0.5;
				 outerRadius: 1.0)
		equals: (BlAnnulusSectorGeometry new
				 startAngle: 0;
				 endAngle: 90;
				 innerRadius: 0.5;
				 outerRadius: 1.0).
	self
		deny: (BlAnnulusSectorGeometry new
				 startAngle: 0;
				 endAngle: 90;
				 innerRadius: 0.6;
				 outerRadius: 1.0)
		equals: (BlAnnulusSectorGeometry new
				 startAngle: 0;
				 endAngle: 90;
				 innerRadius: 0.5;
				 outerRadius: 1.0).
	self
		deny: (BlAnnulusSectorGeometry new
				 startAngle: 0;
				 endAngle: 90;
				 innerRadius: 0.5;
				 outerRadius: 0.9)
		equals: (BlAnnulusSectorGeometry new
				 startAngle: 0;
				 endAngle: 90;
				 innerRadius: 0.5;
				 outerRadius: 1.0)
]

{ #category : #tests }
BlGeometryTest >> testEqualityBlBezierCurveGeometry [

	self
		assert: (BlBezierCurveGeometry controlPoints: {
					 (0 @ 0).
					 (100 @ 100).
					 (0 @ 50) })
		equals: (BlBezierCurveGeometry controlPoints: {
					 (0 @ 0).
					 (100 @ 100).
					 (0 @ 50) }).
	self
		deny: (BlBezierCurveGeometry controlPoints: {
					 (0 @ 0).
					 (100 @ 100).
					 (50 @ 0) })
		equals: (BlBezierCurveGeometry controlPoints: {
					 (0 @ 0).
					 (100 @ 100).
					 (0 @ 50) })
]

{ #category : #tests }
BlGeometryTest >> testEqualityBlCircleGeometry [

	self assert: BlCircleGeometry new equals: BlCircleGeometry new
]

{ #category : #tests }
BlGeometryTest >> testEqualityBlEllipseGeometry [

	self assert: BlEllipseGeometry new equals: BlEllipseGeometry new
]

{ #category : #tests }
BlGeometryTest >> testEqualityBlEmptyGeometry [

	self assert: BlEmptyGeometry new equals: BlEmptyGeometry new
]

{ #category : #tests }
BlGeometryTest >> testEqualityBlLineGeometry [

	self
		assert: (BlLineGeometry from: 0 @ 0 to: 100 @ 100)
		equals: (BlLineGeometry from: 0 @ 0 to: 100 @ 100).
	self
		deny: (BlLineGeometry from: 0 @ 0 to: 100 @ 100)
		equals: (BlLineGeometry from: 0 @ 0 to: 0 @ 100)
]

{ #category : #tests }
BlGeometryTest >> testEqualityBlPolygonGeometry [

	self
		assert: (BlPolygonGeometry vertices: {
					 (0 @ 0).
					 (100 @ 100).
					 (0 @ 50) })
		equals: (BlPolygonGeometry vertices: {
					 (0 @ 0).
					 (100 @ 100).
					 (0 @ 50) }).
	self
		deny: (BlPolygonGeometry vertices: {
					 (0 @ 0).
					 (100 @ 100).
					 (50 @ 0) })
		equals: (BlPolygonGeometry vertices: {
					 (0 @ 0).
					 (100 @ 100).
					 (0 @ 50) })
]

{ #category : #tests }
BlGeometryTest >> testEqualityBlPolylineGeometry [

	self
		assert: (BlPolylineGeometry vertices: {0@0 . 100@100 . 0 @ 50})
		equals: (BlPolylineGeometry vertices: {0@0 . 100@100 . 0 @ 50}).
	self
		deny: (BlPolylineGeometry vertices: {0@0 . 100@100 . 50 @ 0})
		equals: (BlPolylineGeometry vertices: {0@0 . 100@100 . 0 @ 50}).
]

{ #category : #tests }
BlGeometryTest >> testEqualityBlRectangleGeometry [

	self assert: BlRectangleGeometry new equals: BlRectangleGeometry new
]

{ #category : #tests }
BlGeometryTest >> testEqualityBlRoundedRectangleGeometry [

	self assert: (BlRoundedRectangleGeometry cornerRadius: 5) equals: (BlRoundedRectangleGeometry cornerRadius: 5).
	self deny: (BlRoundedRectangleGeometry cornerRadius: 4) equals: (BlRoundedRectangleGeometry cornerRadius: 5)
]

{ #category : #tests }
BlGeometryTest >> testEqualityBlSquareGeometry [

	self assert: BlSquareGeometry new equals: BlSquareGeometry new
]

{ #category : #tests }
BlGeometryTest >> testEqualityBlTriangleGeometry [

	self
		assert: BlTriangleGeometry new beBottom
		equals: BlTriangleGeometry new beBottom.
	self
		assert: BlTriangleGeometry new beLeft
		equals: BlTriangleGeometry new beLeft.
	self
		assert: BlTriangleGeometry new beRight
		equals: BlTriangleGeometry new beRight.
	self
		assert: BlTriangleGeometry new beTop
		equals: BlTriangleGeometry new beTop.

	self
		deny: BlTriangleGeometry new beBottom
		equals: BlTriangleGeometry new beLeft.
	self
		deny: BlTriangleGeometry new beBottom
		equals: BlTriangleGeometry new beRight.
	self
		deny: BlTriangleGeometry new beBottom
		equals: BlTriangleGeometry new beTop.

	self
		deny: BlTriangleGeometry new beLeft
		equals: BlTriangleGeometry new beBottom.
	self
		deny: BlTriangleGeometry new beLeft
		equals: BlTriangleGeometry new beRight.
	self
		deny: BlTriangleGeometry new beLeft
		equals: BlTriangleGeometry new beTop.

	self
		deny: BlTriangleGeometry new beRight
		equals: BlTriangleGeometry new beLeft.
	self
		deny: BlTriangleGeometry new beRight
		equals: BlTriangleGeometry new beBottom.
	self
		deny: BlTriangleGeometry new beRight
		equals: BlTriangleGeometry new beTop.

	self
		deny: BlTriangleGeometry new beTop
		equals: BlTriangleGeometry new beLeft.
	self
		deny: BlTriangleGeometry new beTop
		equals: BlTriangleGeometry new beRight.
	self
		deny: BlTriangleGeometry new beTop
		equals: BlTriangleGeometry new beBottom
]
