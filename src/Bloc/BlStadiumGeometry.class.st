"
A stadium is a geometric figure consisting of a rectangle with top and bottom lengths a whose ends are capped off with semicircles of radius r.
"
Class {
	#name : #BlStadiumGeometry,
	#superclass : #BlElementVectorGeometry,
	#category : #'Bloc-Basic'
}

{ #category : #'as yet unclassified' }
BlStadiumGeometry >> buildPathOnSpartaCanvas: aCanvas [
	| aRadius aDiameter |
	
	aRadius := self radius.
	aDiameter := aRadius * 2.

	(aDiameter < self extent y)
		ifTrue: [
			aRadius := self extent y / 2.0.
			^ aCanvas shape circleAt: aRadius asPoint radius: aRadius ].

	^ aCanvas path
		relative;
		moveTo: aRadius @ 0;
		lineTo: (self extent x - aDiameter) @ 0;
		cwArcTo: 0 @ aDiameter angle: 180 degreesToRadians;
		lineTo: (self extent x - aDiameter) negated @ 0;
		cwArcTo: 0 @ aDiameter negated angle: 180 degreesToRadians;
		close;
		build
]

{ #category : #geometry }
BlStadiumGeometry >> matchExtent: aPoint [
	extent := aPoint
]

{ #category : #geometry }
BlStadiumGeometry >> radius [
	"Compute the radius of the semicircles"
	
	^ self extent min / 2.0
]
