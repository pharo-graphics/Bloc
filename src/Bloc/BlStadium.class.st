"
A stadium is a geometric figure consisting of a rectangle with top and bottom lengths a whose ends are capped off with semicircles of radius r.

"
Class {
	#name : #BlStadium,
	#superclass : #BlElementVectorGeometry,
	#category : #'Bloc-Basic'
}

{ #category : #geometry }
BlStadium >> matchExtent: aPoint [
	extent := aPoint
]

{ #category : #geometry }
BlStadium >> radius [
	"Compute the radius of the semicircles"
	
	^ self extent min / 2.0
]
