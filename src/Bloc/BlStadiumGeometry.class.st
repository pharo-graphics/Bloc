"
A stadium is a geometric figure consisting of a rectangle with top and bottom lengths a whose ends are capped off with semicircles of radius r.
"
Class {
	#name : #BlStadiumGeometry,
	#superclass : #BlElementVectorGeometry,
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #examples }
BlStadiumGeometry class >> example [
	<sampleInstance>
	<demo>
	
	| extents gap space |
	extents := { 200@100. 100@200. 100@100 }.
	gap := 10.

	space := BlSpace new.
	space extent: 400 @ 200.

	space root layout: (BlLinearLayout new cellSpacing: gap; yourself).

	extents do: [ :each |
		space root addChild: (BlElement new
			size: each;
			border: (BlBorder paint: Color black width: 2);
			background: Color blue;
			geometry: BlStadiumGeometry new;
			addEventHandlerOn: BlMouseEnterEvent do: [ :evt | evt target opacity: 0.5 ];
			addEventHandlerOn: BlMouseLeaveEvent do: [ :evt | evt target opacity: 1.0 ];
			yourself) ].

	^ space show
]

{ #category : #'geometry testing' }
BlStadiumGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	"Answer whether aPoint is contained by this geometry.
	Assume aPoint is already inside the geometry bounds rectangle."

	extent x > extent y ifTrue: [
		^ self containsPointHorizontalStadium: aPoint ].

	extent x < extent y ifTrue: [
		^ self containsPointVerticalStadium: aPoint ].

	^ self containsPointCircle: aPoint
]

{ #category : #'as yet unclassified' }
BlStadiumGeometry >> containsPointCircle: aPoint [
	"We assume extent x = extent y"

	| radius |
	radius := extent x / 2.
	^ ((aPoint x - radius) squared + (aPoint y - radius) squared) < radius squared
]

{ #category : #'geometry testing' }
BlStadiumGeometry >> containsPointHorizontalStadium: aPoint [

	| radius x1 x2 |
	radius := extent y / 2.0.
	x1 := radius.
	x2 := extent x - radius.

	"First semicircle?"
	aPoint x < x1 ifTrue: [
		^ (aPoint distanceTo: radius asPoint) <= radius ].

	"Last semicircle?"
	aPoint x > x2 ifTrue: [
		^ (aPoint distanceTo: (x2 @ radius)) <= radius ].

	"Then, it's in the middle"
	^ true
]

{ #category : #'geometry testing' }
BlStadiumGeometry >> containsPointVerticalStadium: aPoint [

	| radius y1 y2 |
	radius := extent x / 2.0.
	y1 := radius.
	y2 := extent y - radius.

	"First semicircle?"
	aPoint y < y1 ifTrue: [
		^ (aPoint distanceTo: radius asPoint) <= radius ].

	"Last semicircle?"
	aPoint y > y2 ifTrue: [
		^ (aPoint distanceTo: (radius @ y2)) <= radius ].

	"Then, it's in the middle"
	^ true
]

{ #category : #testing }
BlStadiumGeometry >> hasCaps [
	"Answer whether my path has caps, i.e. if I include an open line."

	^ false
]

{ #category : #testing }
BlStadiumGeometry >> hasJoins [
	"Answer whether I have joins, i.e. my path presents edges between a segment and another."

	^ false
]

{ #category : #geometry }
BlStadiumGeometry >> matchExtent: aPoint [

	extent := aPoint
]
