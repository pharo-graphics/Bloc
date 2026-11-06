"
I am a sector of an annulus: a part of a ring, centered in my element.
An annulus is the region between two concentric circles (see https://en.wikipedia.org/wiki/Annulus_(mathematics)).

### Responsibility
- Know my start and end angles, in degrees, measured clockwise from the right (the x axis, with y going down).
- Know my inner and outer radii as fractions, between 0 and 1, of the half of the smallest side of the element.
- Build the path of the sector and contain the points inside it.

### Collaborators
- `ToAnnulusSectorGeometry` adds a gap between adjacent sectors, for circular menus and pie charts in Toplo.

### Public API
```
BlAnnulusSectorGeometry new
	startAngle: 0;
	endAngle: 270;
	innerRadius: 0.5;
	outerRadius: 1.0;
	yourself.
aSector absoluteInnerRadius. ""in pixels, once the element gave me its extent""
```
By default I go from 0 to 270 degrees, with an inner radius of 0.45 and an outer radius of 1.

See `BlAnnulusSectorGeometry class >> #exampleAnnulusSector`, and run `BlAnnulusSectorGeometry class >> #scriptAnglesAndRadii`.

### Implementation Points
- `innerRadius:` and `outerRadius:` clamp their argument between 0 and 1.
- A full ring (0 to 360 degrees) still draws the two radial sides of the sector, as a line at the start angle.
- Two annulus sectors are equal when they have the same angles and radii.

**Instance Variables**
- startAngle, endAngle: in degrees, clockwise from the right.
- innerRadius, outerRadius: fractions of the largest radius that fits in the element.
"
Class {
	#name : #BlAnnulusSectorGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'startAngle',
		'endAngle',
		'innerRadius',
		'outerRadius'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #examples }
BlAnnulusSectorGeometry class >> exampleAnnulusSector [
	"Answer a three quarter ring: from 0 to 270 degrees, with an inner radius of half the outer radius."

	<sampleInstance>
	^ self new
		  startAngle: 0;
		  endAngle: 270;
		  innerRadius: 0.5;
		  yourself
]

{ #category : #script }
BlAnnulusSectorGeometry class >> scriptAnglesAndRadii [
	"Show how the angles (in degrees, clockwise from the right) and the radii
	(fractions of the half of the smallest side of the element) shape an annulus sector."

	<script>
	self demoOpen: ({ 
			 ('0 to 270, inner 0.45 (default)' -> self new).
			 ('0 to 360, inner 0.8' -> (self new
				   startAngle: 0;
				   endAngle: 360;
				   innerRadius: 0.8;
				   yourself)).
			 ('-90 to 0, inner 0' -> (self new
				   startAngle: -90;
				   endAngle: 0;
				   innerRadius: 0;
				   yourself)).
			 ('45 to 135, inner 0.5, outer 0.8' -> (self new
				   startAngle: 45;
				   endAngle: 135;
				   innerRadius: 0.5;
				   outerRadius: 0.8;
				   yourself)) } collect: [ :each | 
			 self
				 demoCellFor: (self demoElementFor: each value extent: 90 @ 90)
				 caption: each key ])
]

{ #category : #comparing }
BlAnnulusSectorGeometry >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].

	^ self startAngle = anObject startAngle and: [
		  self endAngle = anObject endAngle and: [
			  self innerRadius = anObject innerRadius and: [
				  self outerRadius = anObject outerRadius ] ] ].
]

{ #category : #'private - geometry' }
BlAnnulusSectorGeometry >> absoluteInnerRadius [
	<return: #Number>
	
	^ self radius * innerRadius
]

{ #category : #'private - geometry' }
BlAnnulusSectorGeometry >> absoluteOuterRadius [
	<return: #Number>
	
	^ self radius * outerRadius
]

{ #category : #'private - geometry' }
BlAnnulusSectorGeometry >> center [
	<return: #Point>
	
	^ self extent / 2.0
]

{ #category : #'geometry testing' }
BlAnnulusSectorGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	"Answer whether aPoint is contained by this geometry.

	Adapted from RSPieSlice>>#preciseIncludesPoint:"

	| p d n a b |
	
	"Check if distance is between right interval"
	p := aPoint - self center.
	d := p distanceTo: 0.0@0.0.
	(d between: self absoluteInnerRadius and: self absoluteOuterRadius)
		ifFalse: [ ^ false ].

	"Check the angle"
	n := p angle radiansToDegrees % 360.
	a := self startAngle % 360.
	b := self endAngle % 360.

	^ a < b
		ifTrue: [ n between: a and: b ]
		ifFalse: [ a <= n or: [ n <= b ] ]
]

{ #category : #accessing }
BlAnnulusSectorGeometry >> endAngle [
	^ endAngle
]

{ #category : #accessing }
BlAnnulusSectorGeometry >> endAngle: anAngleInDegrees [
	endAngle := anAngleInDegrees.
	self releaseCache
]

{ #category : #testing }
BlAnnulusSectorGeometry >> hasCaps [

	^ false
]

{ #category : #testing }
BlAnnulusSectorGeometry >> hasJoins [

	^ true
]

{ #category : #initialization }
BlAnnulusSectorGeometry >> initialize [
	super initialize.
	
	startAngle := 0.
	endAngle := 270.
	innerRadius := 0.45.
	outerRadius := 1.0
]

{ #category : #accessing }
BlAnnulusSectorGeometry >> innerRadius [
	"An inner radius as a fraction of the max radius of the annulus [0..1]"
	<return: #Number>

	^ innerRadius
]

{ #category : #accessing }
BlAnnulusSectorGeometry >> innerRadius: aNumber [
	"Set inner radius as a fraction of the max radius of the annulus [0..1]"

	innerRadius := aNumber min: 1.0 max: 0.0.
	self releaseCache
]

{ #category : #testing }
BlAnnulusSectorGeometry >> isFullTurn [
	"Answer whether I sweep a whole turn or more, so that I am a full ring or disk."

	^ (self endAngle - self startAngle) abs >= 360
]

{ #category : #geometry }
BlAnnulusSectorGeometry >> matchExtent: aPoint [
	"Resize geometry to exactly match provided extent as a Point"

	extent := aPoint
]

{ #category : #accessing }
BlAnnulusSectorGeometry >> outerRadius [
	"An outer radius as a fraction of the max radius of the annulus [0..1]"
	<return: #Number>

	^ outerRadius
]

{ #category : #accessing }
BlAnnulusSectorGeometry >> outerRadius: aNumber [
	"Set outer radius as a fraction of the max radius of the annulus [0..1]"
	outerRadius := aNumber min: 1.0 max: 0.0.
	self releaseCache
]

{ #category : #'private - geometry' }
BlAnnulusSectorGeometry >> pointFromAngle: anAngleInRadians andRadius: aRadius around: aCenter [
	"Convert from spherical coordinates to cartesian coordinates"
	<return: #Point>
	| aX aY |
	
	aX := aCenter x + (aRadius * anAngleInRadians cos).
	aY := aCenter y + (aRadius * anAngleInRadians sin).

	^ aX @ aY
]

{ #category : #'private - geometry' }
BlAnnulusSectorGeometry >> radius [
	<return: #Number>
	
	^ self extent min / 2.0
]

{ #category : #accessing }
BlAnnulusSectorGeometry >> startAngle [
	^ startAngle
]

{ #category : #accessing }
BlAnnulusSectorGeometry >> startAngle: anAngleInDegrees [
	startAngle := anAngleInDegrees.
	self releaseCache
]
