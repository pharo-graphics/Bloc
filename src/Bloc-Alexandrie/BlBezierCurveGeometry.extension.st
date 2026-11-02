Extension { #name : #BlBezierCurveGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlBezierCurveGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext |
		self aeDrawAccordingToControlPointsOn: cairoContext strokeWidth: aBlElement border width ]
]

{ #category : #'*Bloc-Alexandrie' }
BlBezierCurveGeometry >> aeDrawAccordingToControlPointsOn: cairoContext strokeWidth: strokeWidth [
	"Based on RSAthensRenderer>>#buildBezierPath:

	For the cubic (4-point) case we choose between two rendering strategies:

	  REGULAR PATH  — cairo_curve_to (cairo_curve_to).
	    Cairo's native bezier stroking is fast and correct when the local
	    radius of curvature at both endpoints is larger than the stroke
	    half-width.

	  SAFE PATH  — De Casteljau polyline (flattenedCubicVerticesDo:).
	    When one of the end control segments (P0→P1 or P2→P3) is shorter
	    than halfWidth, the radius of curvature at that endpoint is smaller
	    than the stroke radius.  Cairo then builds a self-intersecting stroke
	    outline polygon, which it fills incorrectly — producing a visible blob
	    or fin artifact.  Emitting explicit lineTo: calls instead makes Cairo
	    use its polyline stroking code, which handles inner corners with a
	    concave vertex join and never self-intersects."

	controlPoints size = 2 ifTrue: [
		cairoContext
			lineFrom: controlPoints first
			to: controlPoints second.
		^ self ].

	controlPoints size = 3 ifTrue: [
		cairoContext
			moveTo: controlPoints first;
			quadraticCurveFromCurrentPoint: controlPoints first
				via: controlPoints second
				to: controlPoints third.
		^ self ].

	controlPoints size = 4 ifTrue: [
		| p0 p1 p2 p3 halfWidth |
		p0 := controlPoints first.
		p1 := controlPoints second.
		p2 := controlPoints third.
		p3 := controlPoints fourth.
		halfWidth := strokeWidth / 2.0.

		((p1 distanceTo: p0) < halfWidth
			or: [ (p2 distanceTo: p3) < halfWidth ])
			ifTrue: [
				"Safe path: De Casteljau flattening avoids self-intersecting stroke outline."
				self flattenedCubicVerticesDo: [ :x :y |
					cairoContext lineToX: x y: y ] ]
			ifFalse: [
				"Regular path: Cairo's native bezier stroke is correct here."
				cairoContext
					moveTo: p0;
					curveVia: p1
					      via: p2
					       to: p3 ].
		^ self ].

	self notYetImplemented
]
