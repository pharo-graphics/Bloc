"
I am mutable implementation of Rectangle which stores coordinates as Numbers and not Points.
I am very usefull for chainable bounds transformations and may be transformed in-place by BlMatrix2D and BlMatrix3D
"
Class {
	#name : #BlBounds,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'left',
		'top',
		'right',
		'bottom'
	],
	#category : #'Bloc-Basic-Bounds'
}

{ #category : #'instance creation' }
BlBounds class >> fromRectangle: aRectangle [
	^ self new
		rectangle: aRectangle;
		yourself
]

{ #category : #'instance creation' }
BlBounds class >> left: aLeft top: aTop right: aRight bottom: aBottom [
	<return: #BlBounds>

	^ self new left: aLeft top: aTop right: aRight bottom: aBottom
]

{ #category : #'instance creation' }
BlBounds class >> origin: anOrigin corner: aCorner [

	^ self new origin: anOrigin corner: aCorner
]

{ #category : #'instance creation' }
BlBounds class >> origin: anOrigin extent: anExtent [

	self
		assert: [ anExtent x >= 0 and: [ anExtent y >= 0 ] ]
		description: [ 'Extent must be positive!' ].

	^ self new
		left: anOrigin x
		top: anOrigin y
		right: anOrigin x + anExtent x
		bottom: anOrigin y + anExtent y;
		yourself
]

{ #category : #comparing }
BlBounds >> = aRectangle [
	"Answer true if the receiver's species, origin and corner match aRectangle's."

	^ (self species = aRectangle species or: [ aRectangle isRectangle ])
		and: [ top = aRectangle top
			and: [ right = aRectangle right
				and: [ bottom = aRectangle bottom
					and: [ left = aRectangle left ] ] ] ]
]

{ #category : #converting }
BlBounds >> asRectangle [
	"Convert me to immutable Rectangle.
	Note, that using left:right:top:bottom: is the fastest way to create
	a rectangle from set of numbers (faster than Point#>>corner:)"
	<return: #Rectangle>

	^ Rectangle left: left right: right top: top bottom: bottom
]

{ #category : #'debug - asserting' }
BlBounds >> assertFinite [
	self
		assert: [ left < Float infinity and: [ left > Float negativeInfinity ] ]
		description: [ 'Left must not be infinity' ].
	
	self
		assert: [ right < Float infinity and: [ right > Float negativeInfinity ] ]
		description: [ 'Right must not be infinity' ].

	self
		assert: [ top < Float infinity and: [ top > Float negativeInfinity ] ]
		description: [ 'Top must not be infinity' ].

	self
		assert: [ bottom < Float infinity and: [ bottom > Float negativeInfinity ] ]
		description: [ 'Bottom must not be infinity' ].
]

{ #category : #accessing }
BlBounds >> atRandom [
	"Return a random integer point within this bounds"
	<return: #Point>
	
	^ (self topLeft + (self width atRandom @ self height atRandom)) asIntegerPoint
]

{ #category : #accessing }
BlBounds >> bottom [
	^ bottom
]

{ #category : #accessing }
BlBounds >> bottom: aNumber [
	bottom := aNumber.

	self assertFinite
]

{ #category : #accessing }
BlBounds >> bottomCenter [
	"Answer the point at the center of the receiver's bottom horizontal line."
	<return: #Point>

	^ self center x @ self bottom
]

{ #category : #accessing }
BlBounds >> bottomLeft [
	"Answer the point at the left edge of the bottom horizontal line of the receiver."
	<return: #Point>

	^ self origin x @ self corner y
]

{ #category : #accessing }
BlBounds >> bottomRight [
	"Answer the point at the right edge of the bottom horizontal line of the receiver."
	<return: #Point>

	^ self corner
]

{ #category : #initialization }
BlBounds >> bounds: aBlBounds [
	self
		left: aBlBounds left
		top: aBlBounds top
		right: aBlBounds right
		bottom: aBlBounds bottom
]

{ #category : #accessing }
BlBounds >> center [
	<return: #Point>

	^ ((left / 2.0) + (right / 2.0)) @ ((top / 2.0) + (bottom / 2.0))
]

{ #category : #accessing }
BlBounds >> centerLeft [
	<return: #Point>

	^ self left @ self center y
]

{ #category : #accessing }
BlBounds >> centerRight [
	<return: #Point>

	^ self right @ self center y
]

{ #category : #'vector functions' }
BlBounds >> clockwiseEdges [
	<return: #Collection of: #BlRay>

	^ { 
		BlRay from: self topLeft directed: (self topRight - self topLeft) asBlocVector.
		BlRay from: self topRight directed: (self bottomRight - self topRight) asBlocVector.
		BlRay from: self bottomRight directed: (self bottomLeft - self bottomRight) asBlocVector.
		BlRay from: self bottomLeft directed: (self topLeft - self bottomLeft) asBlocVector.
	}
]

{ #category : #testing }
BlBounds >> closeTo: aBlBounds [
	"Return true if I am close to the given bounds"
	<return: #Boolean>
	
	^ (self left closeTo: aBlBounds left)
		and: [ (self right closeTo: aBlBounds right)
			and: [ (self top closeTo: aBlBounds top)
				and: [ (self bottom closeTo: aBlBounds bottom) ] ] ]
]

{ #category : #'vector functions' }
BlBounds >> closestEdgeTo: aPoint [
	<return: #BlRay>

	^ self counterClockwiseEdges detectMin: [ :aRay | aRay distanceTo: aPoint ]
]

{ #category : #testing }
BlBounds >> containedInRect: aRectangle [
	"Answer whether a receiver is within a aRectangle"
	<return: #Boolean>
	| aLeft aTop aRight aBottom |
	
	aLeft := aRectangle left.
	aTop := aRectangle top.
	aRight := aRectangle right.
	aBottom := aRectangle bottom.

	^ aLeft <= left and: [
		aTop <= top and: [
			aRight >= right and: [
				aBottom >= bottom ] ] ]
]

{ #category : #testing }
BlBounds >> containsPoint: aPoint [ 
	"Answer whether aPoint is within the receiver."
	<return: #Boolean>

	^ self origin <= aPoint and: [ aPoint < self corner ]
]

{ #category : #testing }
BlBounds >> containsRect: aRectangle [
	"Answer whether aRectangle is within the receiver"
	<return: #Boolean>
	| aLeft aTop aRight aBottom |
	
	aLeft := aRectangle left.
	aTop := aRectangle top.
	aRight := aRectangle right.
	aBottom := aRectangle bottom.
	
	^ aLeft >= left and: [
		aTop >= top and: [
			aRight <= right and: [
				aBottom <= bottom ] ] ]
]

{ #category : #accessing }
BlBounds >> corner [
	^ right @ bottom
]

{ #category : #'vector functions' }
BlBounds >> counterClockwiseEdges [
	<return: #Collection of: #BlRay>
	
	^ { 
		BlRay from: self topRight directed: (self topLeft - self topRight) asBlocVector.
		BlRay from: self topLeft directed: (self bottomLeft - self topLeft) asBlocVector.
		BlRay from: self bottomLeft directed: (self bottomRight - self bottomLeft) asBlocVector.		
		BlRay from: self bottomRight directed: (self topRight - self bottomRight) asBlocVector.
	}
]

{ #category : #accessing }
BlBounds >> encompass [
	| newLeft newTop newRight newBottom |
	
	newLeft := left min: right.
	newTop := top min: bottom.
	newRight := left max: right.
	newBottom := top max: bottom.
	
	left := newLeft.
	top := newTop.
	right := newRight.
	bottom := newBottom
]

{ #category : #'rectangle functions' }
BlBounds >> encompass: aPoint [ 
	"Inplace encompass me so that I contain both the receiver and aPoint."

	top := top min: aPoint y.
	right := right max: aPoint x.
	left := left min: aPoint x.
	bottom := bottom max: aPoint y.
	
	self assertFinite
]

{ #category : #'rectangle functions' }
BlBounds >> expandBy: aDelta [ 
	"Outset me by delta. Delta is a Rectangle, Point, or Number."

	^ aDelta isRectangle
		ifTrue: [ self expandByMargin: aDelta ]
		ifFalse: [ aDelta isPoint
			ifTrue: [ self expandByPoint: aDelta ]
			ifFalse: [ aDelta isNumber
				ifTrue: [ self expandByNumber: aDelta ]
				ifFalse: [ self expandByMargin: aDelta ] ] ]
]

{ #category : #'rectangle functions' }
BlBounds >> expandByLeft: aLeft top: aTop right: aRight bottom: aBottom [

	left := left - aLeft.
	top := top - aTop.
	right := right + aRight.
	bottom := bottom + aBottom.
	
	self assertFinite
]

{ #category : #'rectangle functions' }
BlBounds >> expandByMargin: aMargin [ 

	left := left - aMargin left.
	top := top - aMargin top.
	right := right + aMargin right.
	bottom := bottom + aMargin bottom.
	
	self assertFinite
]

{ #category : #'rectangle functions' }
BlBounds >> expandByNumber: aNumber [ 
		
	left := left - aNumber.
	top := top - aNumber.
	right := right + aNumber.
	bottom := bottom + aNumber.
	
	self assertFinite
]

{ #category : #'rectangle functions' }
BlBounds >> expandByPoint: aPoint [ 
	
	left := left - aPoint x.
	top := top - aPoint y.
	right := right + aPoint x.
	bottom := bottom + aPoint y.
	
	self assertFinite
]

{ #category : #accessing }
BlBounds >> expanded [
	"Transform me so that origin and corner are rounded to integers.
	Rounding is done by upper value on origin and lower value on corner so that
	self is inside rounded rectangle."
	
	left := left floor.
	top := top floor.
	right := right ceiling.
	bottom := bottom ceiling
]

{ #category : #accessing }
BlBounds >> extent [

	^ (right - left) @ (bottom - top)
]

{ #category : #initialization }
BlBounds >> extent: aPoint [
	bottom := top + aPoint y.
	right := left + aPoint x
]

{ #category : #testing }
BlBounds >> hasPositiveExtent [
	^ right > left and: [ bottom > top ]
]

{ #category : #accessing }
BlBounds >> height [
	^ bottom - top
]

{ #category : #initialization }
BlBounds >> initialize [
	super initialize.
	
	left := 0.
	top := 0.
	right := 0.
	bottom := 0
]

{ #category : #'rectangle functions' }
BlBounds >> intersect: aRectangle ifNone: aBlock [
	"Answer a Rectangle that is the area in which the receiver overlaps with 
	aRectangle. 
	If there's no overlap, evaluate the block instead"
	| aLeft aTop aRight aBottom newLeft newTop newRight newBottom |

	(self intersects: aRectangle)
		ifFalse: [ ^ aBlock value ].
	
	aLeft := aRectangle left.
	aTop := aRectangle top.
	aRight := aRectangle right.
	aBottom := aRectangle bottom.
	
	newLeft := aLeft max: left.
	newTop := aTop max: top.
	newRight := aRight min: right.
	newBottom := aBottom min: bottom.

	^ self class new
		left: newLeft
		top: newTop
		right: newRight
		bottom: newBottom
]

{ #category : #testing }
BlBounds >> intersects: aRectangle [ 
	"Answer whether aRectangle intersects the receiver anywhere"
	<return: #Boolean>
	| aLeft aTop aRight aBottom |
	
	aLeft := aRectangle left.
	aTop := aRectangle top.
	aRight := aRectangle right.
	aBottom := aRectangle bottom.

	aRight <= left ifTrue: [ ^ false ].
	aBottom <= top ifTrue: [ ^ false ].
	aLeft >= right ifTrue: [ ^ false ].
	aTop >= bottom ifTrue: [ ^ false ].
	^ true
]

{ #category : #accessing }
BlBounds >> left [
	^ left
]

{ #category : #accessing }
BlBounds >> left: aNumber [
	left := aNumber.

	self assertFinite
]

{ #category : #initialization }
BlBounds >> left: aLeft top: aTop corner: aCorner [
	left := aLeft.
	top := aTop.
	right := aCorner x.
	bottom := aCorner y.

	self assertFinite
]

{ #category : #initialization }
BlBounds >> left: aLeft top: aTop right: aRight bottom: aBottom [
	left := aLeft.
	top := aTop.
	right := aRight.
	bottom := aBottom.
	
	self assertFinite
]

{ #category : #'rectangle functions' }
BlBounds >> merge: aRectangle [ 
	"Merge provided rectangle into me.
	aRectangle must not be nil"
	| useRcvr aLeft aTop aRight aBottom minX maxX minY maxY |

	useRcvr := true.

	aLeft := aRectangle left.
	aTop := aRectangle top.
	aRight := aRectangle right.
	aBottom := aRectangle bottom.

	minX := aLeft < left
		ifTrue: 
			[ useRcvr := false.
			aLeft ]
		ifFalse: [ left ].
	maxX := aRight > right
		ifTrue: 
			[ useRcvr := false.
			aRight ]
		ifFalse: [ right ].
	minY := aTop < top
		ifTrue: 
			[ useRcvr := false.
			aTop ]
		ifFalse: [ top ].
	maxY := aBottom > bottom
		ifTrue: 
			[ useRcvr := false.
			aBottom ]
		ifFalse: [ bottom ].
	
	"no need to merge do nothing"
	useRcvr 
		ifTrue: [ ^ self ].
	
	left := minX.
	top := minY.
	right := maxX.
	bottom := maxY.
	
	self assertFinite
]

{ #category : #accessing }
BlBounds >> origin [
	^ left @ top
]

{ #category : #initialization }
BlBounds >> origin: anOrigin corner: aCorner [
	left := anOrigin x.
	top := anOrigin y.
	right := aCorner x.
	bottom := aCorner y.
	
	self assertFinite
]

{ #category : #initialization }
BlBounds >> origin: anOrigin extent: anExtent [
	left := anOrigin x.
	top := anOrigin y.
	right := left + anExtent x.
	bottom := top + anExtent y.
	
	self assertFinite
]

{ #category : #'vector functions' }
BlBounds >> outsideNormalCloseTo: aPoint [
	<return: #BlRay>
	| anEdge aProjection aNormal |
	
	anEdge := self closestEdgeTo: aPoint.
	aProjection := anEdge projection: aPoint.
	aNormal := anEdge vector normal.

	^ BlRay from: aProjection directed: aNormal
]

{ #category : #accessing }
BlBounds >> position [
	<return: #Point>

	^ self origin
]

{ #category : #printing }
BlBounds >> printOn: aStream [ 
	"Refer to the comment in Object|printOn:."

	self origin printOn: aStream.
	aStream nextPutAll: ' corner: '.
	self corner printOn: aStream
]

{ #category : #initialization }
BlBounds >> rectangle: aRectangle [
	self
		left: aRectangle left
		top: aRectangle top
		right: aRectangle right
		bottom: aRectangle bottom
]

{ #category : #accessing }
BlBounds >> right [
	^ right
]

{ #category : #accessing }
BlBounds >> right: aNumber [
	right := aNumber.

	self assertFinite
]

{ #category : #accessing }
BlBounds >> rightCenter [
	"Answer the point at the center of the receiver's right vertical line."
	<return: #Point>

	^ self right @ self center y
]

{ #category : #transforming }
BlBounds >> scaleBy: aFactor [
	
	^ aFactor isPoint
		ifTrue: [ self scaleX: aFactor x Y: aFactor y ]
		ifFalse: [ aFactor isNumber
			ifTrue: [ self scaleX: aFactor Y: aFactor ]
			ifFalse: [ self scaleX: aFactor x Y: aFactor y ] ]
]

{ #category : #transforming }
BlBounds >> scaleX: aX Y: aY [

	left := left * aX.
	top := top * aY.
	right := right * aX.
	bottom := bottom * aY.
	
	self assertFinite
]

{ #category : #printing }
BlBounds >> storeOn: aStream [ 
	"printed form is good for storing too"
	
	aStream nextPut: $(.
	self printOn: aStream.
	aStream nextPut: $).
]

{ #category : #accessing }
BlBounds >> top [
	^ top
]

{ #category : #accessing }
BlBounds >> top: aNumber [
	top := aNumber.

	self assertFinite
]

{ #category : #accessing }
BlBounds >> topCenter [
	"Answer the point at the center of the receiver's top horizontal line."
	<return: #Point>

	^ self center x @ self top
]

{ #category : #accessing }
BlBounds >> topLeft [
	"Answer the point at the top left corner of the receiver's top horizontal line"
	<return: #Point>

	^ left @ top
]

{ #category : #accessing }
BlBounds >> topRight [
	"Answer the point at the top right corner of the receiver's top horizontal line."
	<return: #Point>

	^ self corner x @ self origin y
]

{ #category : #transforming }
BlBounds >> translateBy: aPoint [

	self translateX: aPoint x Y: aPoint y
]

{ #category : #transforming }
BlBounds >> translateX: aX Y: aY [

	left := left + aX.
	top := top + aY.
	right := right + aX.
	bottom := bottom + aY.
	
	self assertFinite
]

{ #category : #accessing }
BlBounds >> width [
	^ right - left
]
