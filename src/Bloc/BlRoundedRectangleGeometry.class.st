"
I am a rectangle with rounded corners, filling the extent of my element.

### Responsibility
- Build a rounded rectangle path, with one radius per corner (top left, top right, bottom right, bottom left).
- Reduce the radii when they are too large for the extent, so that the corners do not overlap
  (`nonOverlappingCornersForBorderWidth:`).
- Build specific paths for an inside or outside border, so the border follows the rounded corners.

### Collaborators
- `BlCornerRadii` holds my four radii.
- `BlRectangleGeometry`, the same shape with square corners.

### Public API
```
BlRoundedRectangleGeometry cornerRadius: 8.
BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new topLeft: 10; topRight: 0; bottomRight: 10; bottomLeft: 0; yourself).
BlRoundedRectangleGeometry new. ""no rounding""
anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 8).
```
See `BlRoundedRectangleGeometry class >> #exampleRoundedRectangle`, and run `BlRoundedRectangleGeometry class >> #scriptCornerRadii`.

**Instance Variables**
- cornerRadii: the `BlCornerRadii` of my four corners.
- center: the center of my extent, updated by `matchExtent:`.
"
Class {
	#name : #BlRoundedRectangleGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'cornerRadii',
		'center'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #factory }
BlRoundedRectangleGeometry class >> cornerRadii: aBlCornerRadii [
	"Create a rounded rectangle with given corner radii"

	^ self basicNew
		initializeWith: aBlCornerRadii;
		yourself
]

{ #category : #factory }
BlRoundedRectangleGeometry class >> cornerRadius: aNumber [
	"Change the radii of all corners to a given number.
	aNumber must not be nil.
	aNumber must be non-negative"

	^ self basicNew
		initializeWith: (BlCornerRadii radius: aNumber);
		yourself
]

{ #category : #examples }
BlRoundedRectangleGeometry class >> exampleRoundedRectangle [
	"Answer a rectangle geometry with all its corners rounded with a radius of 12."

	<sampleInstance>
	^ self cornerRadius: 12
]

{ #category : #factory }
BlRoundedRectangleGeometry class >> new [

	^ self basicNew
		  initializeWith: BlCornerRadii empty;
		  yourself
]

{ #category : #script }
BlRoundedRectangleGeometry class >> scriptCornerRadii [
	"Show rounded rectangles: the same radius on all corners, a different radius on each corner,
	and a radius larger than the element, which is reduced so that the corners do not overlap."

	<script>
	self demoOpen: { 
			(self
				 demoCellFor: (self demoElementFor: (self cornerRadius: 12) extent: 100 @ 70)
				 caption: 'cornerRadius: 12').
			(self
				 demoCellFor: (self
						  demoElementFor: (self cornerRadii: (BlCornerRadii new
									    topLeft: 0;
									    topRight: 30;
									    bottomRight: 0;
									    bottomLeft: 10;
									    yourself))
						  extent: 100 @ 70)
				 caption: 'one radius per corner').
			(self
				 demoCellFor: (self demoElementFor: (self cornerRadius: 100) extent: 100 @ 70)
				 caption: 'cornerRadius: 100') }
]

{ #category : #comparing }
BlRoundedRectangleGeometry >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ self cornerRadii = anObject cornerRadii
]

{ #category : #'geometry testing' }
BlRoundedRectangleGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [

	| radii cornerRadius cornerX cornerY |
	radii := self nonOverlappingCornersForBorderWidth: aBlElement border width.

	aPoint x <= center x
		ifTrue: [
			"The point is in a left quadrant"
			aPoint y <= center y
				ifTrue: [
					"The point is in top-left quadrant"
					cornerRadius := radii topLeft.
					cornerX := radii topLeft.
					cornerY := radii topLeft.
					(aPoint x >= cornerX or: [ aPoint y >= cornerY ])
						ifTrue: [ ^ true ] ]
				ifFalse: [
					"The point is in bottom-left quadrant"
					cornerRadius := radii bottomLeft.
					cornerX := radii bottomLeft.
					cornerY := extent y - radii bottomLeft.
					(aPoint x >= cornerX or: [ aPoint y <= cornerY ])
						ifTrue: [ ^ true ] ] ]
		ifFalse: [
			"The point is in a right quadrant"
			aPoint y <= center y
				ifTrue: [
					"The point is in top-right quadrant"
					cornerRadius := radii topRight.
					cornerX := extent x - radii topRight.
					cornerY := radii topRight.
					(aPoint x <= cornerX or: [ aPoint y >= cornerY ])
						ifTrue: [ ^ true ] ]
				ifFalse: [
					"The point is in bottom-right quadrant"
					cornerRadius := radii bottomRight.
					cornerX := extent x - radii bottomRight.
					cornerY := extent y - radii bottomRight.
					(aPoint x <= cornerX or: [ aPoint y <= cornerY ])
						ifTrue: [ ^ true ] ] ].
			
	^ ((aPoint x - cornerX) squared
		+ (aPoint y - cornerY) squared)
			< cornerRadius squared
]

{ #category : #accessing }
BlRoundedRectangleGeometry >> cornerRadii [

	^ cornerRadii
]

{ #category : #testing }
BlRoundedRectangleGeometry >> hasCaps [

	^ false
]

{ #category : #testing }
BlRoundedRectangleGeometry >> hasJoins [

	^ false
]

{ #category : #initialization }
BlRoundedRectangleGeometry >> initializeWith: aCornerRadii [

	self initialize.
	
	cornerRadii := aCornerRadii
]

{ #category : #geometry }
BlRoundedRectangleGeometry >> matchExtent: aPoint [

	extent := aPoint.
	center := aPoint / 2.0.
]

{ #category : #private }
BlRoundedRectangleGeometry >> nonOverlappingCornersForBorderWidth: aNumber [
	"Answer either current cornerRadii or a copy of it, that would work with any of the possible outskirts, and considering the current extent."

	^ cornerRadii
		  asNonOverlappingCornerRadiiToFitWidth: ((extent x - aNumber) max: 0.0)
		  height: ((extent y - aNumber) max: 0.0)
]

{ #category : #geometry }
BlRoundedRectangleGeometry >> pointOnPerimeterOfElement: anElement atRadians: aRadians [

	| bounds margin rect rx ry dx dy px py cornerRadius innerWidth innerHeight inCorner adjustedCenter signX signY arcCenter x y scale |
	"1. Compute the bounds rectangle that includes the margin "
	bounds := anElement measuredBounds.
	margin := anElement margin.
	rect := Rectangle
		        origin: bounds topLeft - margin topLeft
		        corner: bounds bottomRight + margin bottomRight.

	adjustedCenter := rect center.
	rx := rect width / 2.
	ry := rect height / 2.

	"2. compute the direction from the angle (unit vector)"
	dx := aRadians cos.
	dy := aRadians sin.

	px := dx * rx.
	py := dy * ry.

	signX := dx sign.
	signY := dy sign.

	"3. get the corner radius from the direction "
	cornerRadius := cornerRadii radiusForDirectionX: dx directionY: dy.

	innerWidth := rx - cornerRadius.
	innerHeight := ry - cornerRadius.

	"4.  check if the direction fits a rounded corner "
	inCorner := (px abs * 2.5) >= innerWidth and: [ (py abs * 2.5) >= innerHeight ].
	"
	dx trace. ' ' trace. rx trace. ' ' trace. px abs trace. ' ' trace. innerWidth traceCr.
	dy trace. ' ' trace. ry trace. ' ' trace. py abs trace. ' ' trace. innerHeight traceCr.
	inCorner traceCr.
	"
	inCorner ifTrue: [ "5. compute the arc angle"
			arcCenter := (signX = 1
				              ifTrue: [ rect right - cornerRadius ]
				              ifFalse: [ rect left + cornerRadius ]) @ (signY = 1
				              ifTrue: [ rect bottom - cornerRadius ]
				              ifFalse: [ rect top + cornerRadius ]).

			"6. compute the point on arc"
			x := arcCenter x + (cornerRadius * dx).
			y := arcCenter y + (cornerRadius * dy).

			^ x @ y ].

	"7. else compute the position on a straight line"
	scale := 1 / (px abs / rx max: py abs / ry).
	x := adjustedCenter x + (dx * rx * scale).
	y := adjustedCenter y + (dy * ry * scale).

	^ x @ y
]
