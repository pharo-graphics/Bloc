"
A stadium is a geometric figure consisting of a rectangle with top and bottom lengths a whose ends are capped off with semicircles of radius r.
"
Class {
	#name : #BlStadiumGeometry,
	#superclass : #BlElementVectorGeometry,
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #geometry }
BlStadiumGeometry >> matchExtent: aPoint [
	extent := aPoint
]

{ #category : #geometry }
BlStadiumGeometry >> radius [
	"Compute the radius of the semicircles"
	
	^ self extent min / 2.0
]
