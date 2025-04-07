"
I am a sector of an annulus. In mathematics, an annulus (the Latin word for ""little ring"" is anulus / annulus, with plural anuli / annuli) is a ring-shaped object, a region bounded by two concentric circles.

See: https://en.wikipedia.org/wiki/Annulus_(mathematics)

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
