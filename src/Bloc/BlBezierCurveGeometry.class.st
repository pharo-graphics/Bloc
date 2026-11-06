"
I am a Bezier curve defined by 2, 3 or 4 control points, in the coordinates of my element.

### Responsibility
- Know my control points; they do not change when the extent of the element changes.
  The curve starts at the first point and ends at the last one; the points in between pull it towards them.
- Build an open path, so I have caps: the border of the element draws me, the background has nothing to fill.
  With 2 points I am a straight line, with 3 a quadratic curve and with 4 a cubic curve.
- Answer the rectangle around my control points as my bounds, and contain the points closer to the curve than half the border width.

### Collaborators
- `BlSigmoidGeometry` computes the control points of an S-shaped cubic curve from its two ends.
- `BlLineGeometry` and `BlPolylineGeometry` draw straight segments.

### Public API
```
BlBezierCurveGeometry controlPoints: { 10 @ 60. 30 @ -10. 70 @ 80. 90 @ 10 }.
aCurve order. ""the number of control points""
```
See `BlBezierCurveGeometry class >> #exampleCubicCurve`, and run `BlBezierCurveGeometry class >> #scriptControlPointCounts`.

### Implementation Points
- My bounds enclose the control points, not only the curve, so they can be larger than what is drawn.
- For hit testing, the cubic curve is flattened into segments (De Casteljau subdivision, about one pixel of tolerance)
  and the result is cached in the path cache; the quadratic curve is approximated by a cubic one sampled at 6 points, so hit testing near it is less precise.
- Two curves are equal when they have the same control points.

**Instance Variables**
- controlPoints: my 2 to 4 points; the first and last are the ends of the curve.
"
Class {
	#name : #BlBezierCurveGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'controlPoints'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #'instance creation' }
BlBezierCurveGeometry class >> controlPoints: aCollection [
	^ self new controlPoints: aCollection
]

{ #category : #examples }
BlBezierCurveGeometry class >> exampleCubicCurve [
	"Answer a cubic Bezier curve: from 10@60 to 90@10, pulled by the control points 30@-10 and 70@80."

	<sampleInstance>
	^ self controlPoints: { 
			  (10 @ 60).
			  (30 @ -10).
			  (70 @ 80).
			  (90 @ 10) }
]

{ #category : #script }
BlBezierCurveGeometry class >> scriptControlPointCounts [
	"Show Bezier curves with 2 control points (a straight line), 3 (a quadratic curve)
	and 4 (a cubic curve). The control points are shown as small red dots."

	<script>
	self demoOpen: ({ 
			 { (10 @ 60). (90 @ 10) }.
			 { (10 @ 60). (50 @ -20). (90 @ 60) }.
			 BlBezierCurveGeometry exampleCubicCurve controlPoints } collect: [ :points | 
			 | curve |
			 curve := self demoElementFor: (self controlPoints: points) extent: 100 @ 70.
			 curve clipChildren: false.
			 points do: [ :each | 
				 curve addChild: (BlElement new
						  geometry: BlCircleGeometry new;
						  background: Color red;
						  extent: 6 @ 6;
						  position: each - 3;
						  yourself) ].
			 self
				 demoCellFor: curve
				 caption: points size printString , ' control points' ])
]

{ #category : #comparing }
BlBezierCurveGeometry >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	
	^ self controlPoints = anObject controlPoints
]

{ #category : #geometry }
BlBezierCurveGeometry >> asPolylineVertices [
	"Answer an Array of Points approximating the curve, for hit-testing.
	The quadratic (3-point) and cubic (4-point) cases reuse the De Casteljau-flattened
	cache that the renderer uses for cubics, so the vertices follow the drawn curve
	within one pixel."

	| result |
	controlPoints size = 2 ifTrue: [
		^ Array
			with: controlPoints first
			with: controlPoints second ].
	result := OrderedCollection new.
	self flattenedCubicVerticesDo: [ :x :y | result add: x @ y ].
	^ result asArray
]

{ #category : #'geometry testing' }
BlBezierCurveGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	"Answer whether aPoint is contained by this geometry.

	Adapted from RSBezier>>#basicIncludesPoint:"

	| lines ir |
	ir := aBlElement border width / 2.
	lines := self asPolylineVertices.

	^ (1 to: lines size - 1) anySatisfy: [ :i |
			aPoint
				onLineFrom: (lines at: i)
				to: (lines at: i + 1)
				within: ir ]

]

{ #category : #accessing }
BlBezierCurveGeometry >> controlPoints [

	^ controlPoints
]

{ #category : #accessing }
BlBezierCurveGeometry >> controlPoints: aCollection [
	"The collection can have between 2 and 4 points."

	controlPoints := aCollection.
	self releaseCache
]

{ #category : #geometry }
BlBezierCurveGeometry >> cubicControlPoints [
	"Answer the four control points of the cubic Bezier tracing exactly my curve.
	 They feed flattenedCubicVerticesDo:, so that hit testing (asPolylineVertices) and the cubic
	 rendering share one flattening, which follows the curve within one pixel.

	 For a cubic (4 points) these are my control points.
	 For a quadratic (3 points) this is the degree elevation of the quadratic: a quadratic with
	 start P0, control point P1 and end P2 is exactly the cubic with control points
	 P0, P0 + 2/3 (P1 - P0), P2 + 2/3 (P1 - P2), P2.
	 Treating P2 as the second cubic control point instead (P0, P1, P2, P2) would describe another
	 curve than the one drawn, and points on the drawn curve would then be missed by hit testing."

	| start via end |
	controlPoints size = 4 ifTrue: [ ^ controlPoints ].
	start := controlPoints first.
	via := controlPoints second.
	end := controlPoints third.
	^ Array
		with: start
		with: start + ((via - start) * (2 / 3))
		with: end + ((via - end) * (2 / 3))
		with: end
]

{ #category : #private }
BlBezierCurveGeometry >> flattenCubicFrom: p0 cp1: p1 cp2: p2 to: p3 into: aCollection depth: depth [
	"Private helper for flattenedCubicVerticesDo:.
	Recursively subdivides the cubic Bezier p0-p1-p2-p3 using De Casteljau and
	appends each new vertex to aCollection (p0 is assumed to be already present).

	Flatness criterion: the perpendicular distance from each interior control
	point to the chord p0→p3 must be ≤ 1.0 user-space unit (≈ 1 pixel).
	Working with squared distances avoids a sqrt per call.

	A depth limit of 16 prevents unbounded recursion on degenerate inputs
	(e.g. all four points coincident)."

	| chordX chordY chordLenSq d1Sq d2Sq q0 q1 q2 r0 r1 mid |

	depth > 16 ifTrue: [
		aCollection add: p3.
		^ self ].

	"Chord vector p0→p3."
	chordX := p3 x - p0 x.
	chordY := p3 y - p0 y.
	chordLenSq := (chordX * chordX) + (chordY * chordY).

	"Negligibly short chord → the whole sub-curve is sub-pixel; close it."
	chordLenSq < 1.0e-8 ifTrue: [
		aCollection add: p3.
		^ self ].

	"Perpendicular-distance² from each interior control point to the chord.
	  d = |cross(chord, p - p0)| / |chord|   →   d² = cross² / chordLenSq"
	d1Sq := ((p1 x - p0 x) * chordY - ((p1 y - p0 y) * chordX)) squared
	        / chordLenSq.
	d2Sq := ((p2 x - p0 x) * chordY - ((p2 y - p0 y) * chordX)) squared
	        / chordLenSq.

	"Flat enough? tolerance = 1.0 px  →  tolerance² = 1.0"
	(d1Sq max: d2Sq) <= 1.0 ifTrue: [
		aCollection add: p3.
		^ self ].

	"Subdivide at t = 0.5 using De Casteljau."
	q0 := (p0 + p1) * 0.5.
	q1 := (p1 + p2) * 0.5.
	q2 := (p2 + p3) * 0.5.
	r0 := (q0 + q1) * 0.5.
	r1 := (q1 + q2) * 0.5.
	mid := (r0 + r1) * 0.5.

	self
		flattenCubicFrom: p0 cp1: q0 cp2: r0 to: mid
		into: aCollection
		depth: depth + 1.
	self
		flattenCubicFrom: mid cp1: r1 cp2: q2 to: p3
		into: aCollection
		depth: depth + 1
]

{ #category : #geometry }
BlBezierCurveGeometry >> flattenedCubicVerticesDo: aBlock [
	"Evaluate aBlock with (x, y) for each vertex of the De Casteljau-flattened
	cubic Bezier path (see cubicControlPoints), including the start point p0.
	The flattened vertex array is computed lazily on first call and stored in
	pathCache geometryPath.  The cache is cleared automatically whenever
	releaseCache is called (e.g. from controlPoints:), which also clears the
	inherited strokedBounds cache.
	Usage:
	  self flattenedCubicVerticesDo: [:x :y | canvas lineToX: x y: y]"

	| vertices |
	vertices := pathCache geometryPath ifNil: [
		| points result |
		points := self cubicControlPoints.
		result := OrderedCollection with: points first.
		self
			flattenCubicFrom: points first
			cp1: points second
			cp2: points third
			to: points fourth
			into: result
			depth: 0.
		result := result asArray.
		pathCache geometryPath: result.
		result ].
	vertices do: [ :each | aBlock value: each x value: each y ]
]

{ #category : #'geometry bounds' }
BlBezierCurveGeometry >> geometryBounds: aBlBounds [

	^ aBlBounds rectangle:
		(self controlPoints
			ifEmpty: [ 0 @ 0 extent: 0 @ 0 ]
			ifNotEmpty: [ :theControlPoints | 
				Rectangle encompassing: theControlPoints ])
]

{ #category : #testing }
BlBezierCurveGeometry >> hasCaps [

	^ true
]

{ #category : #testing }
BlBezierCurveGeometry >> hasJoins [

	^ false
]

{ #category : #initialization }
BlBezierCurveGeometry >> initialize [
	super initialize.

	controlPoints := #()
]

{ #category : #accessing }
BlBezierCurveGeometry >> matchExtent: aPoint [
	extent := aPoint
]

{ #category : #accessing }
BlBezierCurveGeometry >> order [
	"Return an order of a bezier curve (how many control points it has)
	(https://en.wikipedia.org/wiki/B%C3%A9zier_curve#Specific_cases)"
	<return: #Number>

	^ self controlPoints size
]
