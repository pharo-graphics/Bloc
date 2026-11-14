"
I am an S-shaped curve between two points, in the coordinates of my element:
a cubic Bezier curve whose control points I compute.

### Responsibility
- Know my two ends (`from:to:`); they do not change when the extent of the element changes.
- Know my sharpness (between 0 and 1, 0.5 by default): the larger it is, the steeper the middle of the S.
- Know my bending point (between 0 and 1, 0.5 by default): where along the curve the S bends.
- Know my orientation: the curve leaves and reaches its ends horizontally, vertically, or automatically along the largest distance between them (the default).
- Compute my two control points from these properties, and build an open path, so I have caps.

### Collaborators
- `BlBezierCurveGeometry` draws a curve from explicit control points.

### Public API
```
BlSigmoidGeometry from: 10 @ 10 to: 90 @ 60.
(BlSigmoidGeometry from: 10 @ 10 to: 90 @ 60)
	sharpness: 0.8;
	bendingPoint: 0.3;
	beVertical;
	yourself.
```
See `BlSigmoidGeometry class >> #exampleSigmoid`, and run `BlSigmoidGeometry class >> #scriptSharpnessAndBendingPoint`.

### Implementation Points
- `sharpness:` and `bendingPoint:` clamp their argument between 0 and 1.
- `containsPoint:alreadyInGeometryBoundsOf:` answers true for every point of my bounds: hit testing is not precise yet.
- I do not redefine `=`.

**Instance Variables**
- from, to: my two ends.
- fromControl, toControl: the computed control points of the cubic curve.
- sharpness, bendingPoint: numbers between 0 and 1.
- orientation: one of the symbols held by `AutomaticOrientation`, `HorizontalOrientation` and `VerticalOrientation`.
"
Class {
	#name : #BlSigmoidGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'from',
		'to',
		'sharpness',
		'bendingPoint',
		'fromControl',
		'toControl',
		'orientation'
	],
	#classVars : [
		'AutomaticOrientation',
		'HorizontalOrientation',
		'VerticalOrientation'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #examples }
BlSigmoidGeometry class >> exampleSigmoid [
	"Answer an S-shaped curve from 10@10 to 90@60, with the default sharpness and bending point (0.5)."

	<sampleInstance>
	^ self from: 10 @ 10 to: 90 @ 60
]

{ #category : #'instance creation' }
BlSigmoidGeometry class >> from: aPoint to: anotherPoint [

	^ self new
		from: aPoint to: anotherPoint;
		yourself
]

{ #category : #'class initialization' }
BlSigmoidGeometry class >> initialize [

	AutomaticOrientation := #automatic.
	VerticalOrientation := #vertical.
	HorizontalOrientation := #horizontal
]

{ #category : #script }
BlSigmoidGeometry class >> scriptSharpnessAndBendingPoint [
	"Show S-shaped curves between the same two points: the default one, a sharper one,
	one bending close to its start, and one forced to be vertical."

	<script>
	self demoOpen: ({ 
			 ('default' -> self exampleSigmoid).
			 ('sharpness: 1' -> (self exampleSigmoid
				   sharpness: 1;
				   yourself)).
			 ('bendingPoint: 0.2' -> (self exampleSigmoid
				   bendingPoint: 0.2;
				   yourself)).
			 ('beVertical' -> (self exampleSigmoid
				   beVertical;
				   yourself)) } collect: [ :each | 
			 self
				 demoCellFor: (self demoElementFor: each value extent: 100 @ 70)
				 caption: each key ])
]

{ #category : #accessing }
BlSigmoidGeometry >> beAutomatic [

	self orientation: AutomaticOrientation
]

{ #category : #accessing }
BlSigmoidGeometry >> beHorizontal [

	self orientation: HorizontalOrientation
]

{ #category : #accessing }
BlSigmoidGeometry >> beVertical [

	self orientation: VerticalOrientation
]

{ #category : #accessing }
BlSigmoidGeometry >> bendingPoint: aFloatNumber [
	"aFloatNumber must be within interval [0...1]"

	| aNewBendingPoint |
	aNewBendingPoint := aFloatNumber min: 1.0 max: 0.0.
	(bendingPoint closeTo: aNewBendingPoint) ifTrue: [ ^ self ].

	bendingPoint := aNewBendingPoint.
	self updateControlPoints.
	self releaseCache
]

{ #category : #private }
BlSigmoidGeometry >> computeFromControlPoint [
	"I compute the location of the from control point related to the start of the sigmoid based
	on sharpness and bending point"

	| anAbsoluteVector aDistanceBetweenPoints isHorizontal aDistanceToControlPoint |
	
	anAbsoluteVector := (to - from) abs.
	aDistanceBetweenPoints := anAbsoluteVector max.
	
	isHorizontal := self isHorizontal
		ifTrue: [ true ]
		ifFalse: [ self isVertical
			ifTrue: [ false ]
			"the horizontal distance between points is more than vertical"
			ifFalse: [ anAbsoluteVector x >= anAbsoluteVector y ] ].
	
	"when bending point is 0.5 it means that both control points have the same distance from the start and end.
	if bending point is for example than 0.25 then the distance to `from control point` should twice as small as
	to `to control point`"
	aDistanceToControlPoint := bendingPoint <= 0.5
		ifTrue: [ sharpness * aDistanceBetweenPoints * (bendingPoint / 0.5) ]
		ifFalse: [ sharpness * aDistanceBetweenPoints ].
	
	"from control point should be shifted by aDistanceToControlPoint in the direction of the curve"
	^ isHorizontal
		ifTrue: [ (((to - from) x sign * aDistanceToControlPoint) @ 0) + from ]
		ifFalse: [ (0 @ ((to - from) y sign * aDistanceToControlPoint)) + from ]
]

{ #category : #private }
BlSigmoidGeometry >> computeToControlPoint [
	"I compute the location of the to control point related to the start of the sigmoid based
	on sharpness and bending point"

	| anAbsoluteVector aDistanceBetweenPoints isHorizontal aDistanceToControlPoint |
	
	anAbsoluteVector := (to - from) abs.
	aDistanceBetweenPoints := anAbsoluteVector max.
	
	isHorizontal := self isHorizontal
		ifTrue: [ true ]
		ifFalse: [ self isVertical
			ifTrue: [ false ]
			"the horizontal distance between points is more than vertical"
			ifFalse: [ anAbsoluteVector x >= anAbsoluteVector y ] ].
	
	"when bending point is 0.5 it means that both control points have the same distance from the start and end.
	if bending point is for example than 0.75 then the distance to `to control point` should twice as small as
	to `from control point`"
	aDistanceToControlPoint := bendingPoint > 0.5
		ifTrue: [ sharpness * aDistanceBetweenPoints * ((1 - bendingPoint) / 0.5) ]
		ifFalse: [ sharpness * aDistanceBetweenPoints ].
	
	"to control point should be shifted by aDistanceToControlPoint in the opposite direction of the curve"
	^ isHorizontal
		ifTrue: [ (((from - to) x sign * aDistanceToControlPoint) @ 0) + to ]
		ifFalse: [ (0 @ ((from - to) y sign * aDistanceToControlPoint)) + to ]
]

{ #category : #'geometry testing' }
BlSigmoidGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	"Answer whether aPoint is on my curve, within half the border width of aBlElement.
	I am drawn as the cubic Bezier curve from, fromControl, toControl, to, so hit testing is
	delegated to the Bezier geometry, which follows the drawn curve within one pixel."

	^ (BlBezierCurveGeometry controlPoints: { from. fromControl. toControl. to })
		containsPoint: aPoint
		alreadyInGeometryBoundsOf: aBlElement
]

{ #category : #'instance creation' }
BlSigmoidGeometry >> from: aFromPoint to: aToPoint [

	(from = aFromPoint and: [ to = aToPoint ])
		ifFalse: [ self releaseCache ].

	from := aFromPoint.
	to := aToPoint.

	self updateControlPoints
]

{ #category : #'api - bounds' }
BlSigmoidGeometry >> geometryBounds: aBlBounds [

	^ aBlBounds rectangle:
		(Rectangle encompassing: { from. to })
]

{ #category : #testing }
BlSigmoidGeometry >> hasCaps [
	"Answer whether my path has caps, i.e. if I include an open line."

	^ true
]

{ #category : #testing }
BlSigmoidGeometry >> hasJoins [
	"Answer whether I have joins, i.e. my path presents edges between a segment and another."

	^ false
]

{ #category : #initialization }
BlSigmoidGeometry >> initialize [

	super initialize.

	from := 0 @ 0.
	to := 0 @ 0.
	fromControl := 0 @ 0.
	toControl := 0 @ 0.
	bendingPoint := 0.5.
	sharpness := 0.5.
	orientation := AutomaticOrientation
]

{ #category : #private }
BlSigmoidGeometry >> isAutomatic [
	^ orientation = AutomaticOrientation
]

{ #category : #private }
BlSigmoidGeometry >> isHorizontal [
	^ orientation = HorizontalOrientation
]

{ #category : #private }
BlSigmoidGeometry >> isVertical [
	^ orientation = VerticalOrientation
]

{ #category : #geometry }
BlSigmoidGeometry >> matchExtent: aPoint [
	"Resize geometry to exactly match provided extent as a Point"

	extent := aPoint
]

{ #category : #private }
BlSigmoidGeometry >> orientation: anOrientation [

	orientation = anOrientation ifTrue: [ ^ self ].
	orientation := anOrientation.

	self updateControlPoints.
	self releaseCache
]

{ #category : #accessing }
BlSigmoidGeometry >> sharpness: aFloatNumber [
	"aFloatNumber must be within interval [0...1]"

	| aNewSharpness |
	aNewSharpness := aFloatNumber min: 1.0 max: 0.0.
	(sharpness closeTo: aNewSharpness) ifTrue: [ ^ self ].

	sharpness := aNewSharpness.
	self updateControlPoints.
	self releaseCache
]

{ #category : #private }
BlSigmoidGeometry >> updateControlPoints [

	fromControl := self computeFromControlPoint.
	toControl := self computeToControlPoint
]
