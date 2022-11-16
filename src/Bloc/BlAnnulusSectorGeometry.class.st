"
I am a sector of an annulus. In mathematics, an annulus is an area bounded by two concentric circles.

The center of the annulus is the middle of the BlElement. The maximum diameter is given by the element's extent.

My instances have an innerRadius and an outerRadius that are in fact not radius but [0..1] coefficients, that, when multiplied by half element's extent determine the above mentioned concentric circles of the annulus. 

There is an exception: An inner radius coefficient of 0.0 means it is in fact the sector of a circle.

My instances have a start and end angle to determine the sector of the annulus. 
The meaning of the angles are:
* An angle of 0.0 is in the direction of the positive X axis.
* An angle of 90 degrees is in the direction of the positive Y axis.
* Angles increase in the direction from the positive X axis toward the positive Y axis.

"
Class {
	#name : #BlAnnulusSectorGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'innerRadius',
		'outerRadius',
		'endAngleInRadians',
		'startAngleInRadians'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #'private - geometry' }
BlAnnulusSectorGeometry >> absoluteInnerRadius [
	
	^ self radius * innerRadius
]

{ #category : #'private - geometry' }
BlAnnulusSectorGeometry >> absoluteOuterRadius [
	
	^ self radius * outerRadius
]

{ #category : #'private - geometry' }
BlAnnulusSectorGeometry >> center [
	
	^ self extent / 2.0
]

{ #category : #'geometry testing' }
BlAnnulusSectorGeometry >> containsPoint: aPoint in: aBlElement [
	"Answer whether aPoint is contained by this geometry.

	Adapted from RSPieSlice>>#preciseIncludesPoint:"

	| p d n a b |
	
	"Check if distance is between right interval"
	p := aPoint - self center.
	d := p distanceTo: 0.0@0.0.
	(d between: self absoluteInnerRadius and: self absoluteOuterRadius)
		ifFalse: [ ^ false ].

	"Check the angle"
	n := p angle % Float twoPi.
	a := startAngleInRadians % Float twoPi.
	b := endAngleInRadians % Float twoPi.

	^ a < b
		ifTrue: [ n between: a and: b ]
		ifFalse: [ a <= n or: [ n <= b ] ]
]

{ #category : #accessing }
BlAnnulusSectorGeometry >> endAngle [

	^ endAngleInRadians radiansToDegrees
]

{ #category : #accessing }
BlAnnulusSectorGeometry >> endAngle: anAngleInDegrees [
	
	self endAngleInRadians: anAngleInDegrees degreesToRadians
]

{ #category : #accessing }
BlAnnulusSectorGeometry >> endAngleInRadians [

	^ endAngleInRadians
]

{ #category : #accessing }
BlAnnulusSectorGeometry >> endAngleInRadians: anAngleInRadians [

	endAngleInRadians := anAngleInRadians.
	self releaseCache
]

{ #category : #initialization }
BlAnnulusSectorGeometry >> initialize [
	super initialize.
	
	startAngleInRadians := 0.
	endAngleInRadians := 4.71238898038469.
	innerRadius := 0.45.
	outerRadius := 1.0
]

{ #category : #accessing }
BlAnnulusSectorGeometry >> innerRadius [
	"An inner radius as a fraction of the max radius of the annulus [0..1]"

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

	^ outerRadius
]

{ #category : #accessing }
BlAnnulusSectorGeometry >> outerRadius: aNumber [
	"Set outer radius as a fraction of the max radius of the annulus [0..1]"

	outerRadius := aNumber min: 1.0 max: 0.0.
	self releaseCache
]

{ #category : #'private - geometry' }
BlAnnulusSectorGeometry >> radius [
	
	^ self extent min / 2.0
]

{ #category : #accessing }
BlAnnulusSectorGeometry >> startAngle [

	^ startAngleInRadians radiansToDegrees
]

{ #category : #accessing }
BlAnnulusSectorGeometry >> startAngle: anAngleInDegrees [

	self startAngleInRadians: anAngleInDegrees degreesToRadians
]

{ #category : #accessing }
BlAnnulusSectorGeometry >> startAngle: anAngle endAngleDelta: anotherAngle [
	"Establish the start and end angles of this sector, by passing the starting angle expressed as degrees, and a delta. A positive delta is a clockwise sector, while negative counter-clockwise."

	self
		startAngle: anAngle;
		endAngle: anAngle + anotherAngle
]

{ #category : #accessing }
BlAnnulusSectorGeometry >> startAngleInRadians [

	^ startAngleInRadians
]

{ #category : #accessing }
BlAnnulusSectorGeometry >> startAngleInRadians: anAngleInRadians [

	startAngleInRadians := anAngleInRadians.
	self releaseCache
]

{ #category : #accessing }
BlAnnulusSectorGeometry >> startAngleInRadians: anAngleInRadians endAngleDelta: anotherAngleInRadians [
	"Establish the start and end angles of this sector, by passing the starting angle expressed as radians and a delta. A positive delta is a clockwise sector, while negative counter-clockwise."

	self
		startAngleInRadians: anAngleInRadians;
		endAngleInRadians: anAngleInRadians + anotherAngleInRadians
]
