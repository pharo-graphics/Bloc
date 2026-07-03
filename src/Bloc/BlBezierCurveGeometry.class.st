"
I define a geometry of a bezier curve with N control points (of order N)

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

{ #category : #comparing }
BlBezierCurveGeometry >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	
	^ self controlPoints = anObject controlPoints
]

{ #category : #geometry }
BlBezierCurveGeometry >> asPolylineVertices [
	"Answer an Array of Points approximating the curve, for hit-testing.

	For the cubic (4-point) case this reuses the same De Casteljau-flattened
	cache that the renderer uses, so both share a single computation and a
	single allocation.

	For the quadratic (3-point) case a coarse uniform sample is sufficient
	for hit-testing purposes."

	| c b a via1 via2 start end |

	controlPoints size = 2 ifTrue: [
		^ Array
			with: controlPoints first
			with: controlPoints second ].

	controlPoints size = 4 ifTrue: [
		| result |
		result := OrderedCollection new.
		self flattenedCubicVerticesDo: [ :x :y | result add: x @ y ].
		^ result asArray ].

	"size = 3: treat as degenerate cubic (CP2 = CP3) and sample uniformly."
	start := controlPoints first.
	via1 := controlPoints second.
	via2 := controlPoints third.
	end := via2.
	c := 3 * (via1 - start).
	b := 3 * (via2 - via1) - c.
	a := end - start - c - b.

	^ #(0.0 0.2 0.4 0.6 0.8 1.0) collect: [ :t |
		a * (t raisedTo: 3) + (b * (t * t)) + (c * t) + start ]
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
	cubic Bezier path, including the start point p0.

	The flattened vertex array is computed lazily on first call and stored in
	pathCache geometryPath.  The cache is cleared automatically whenever
	releaseCache is called (e.g. from controlPoints:), which also clears the
	inherited strokedBounds cache.

	Usage:
	  self flattenedCubicVerticesDo: [:x :y | canvas lineToX: x y: y]"

	| vertices |
	vertices := pathCache geometryPath ifNil: [
		| result |
		result := OrderedCollection with: controlPoints first.
		self
			flattenCubicFrom: controlPoints first
			cp1: controlPoints second
			cp2: controlPoints third
			to: controlPoints fourth
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
