"
I am an exact geometry resizer.
I make sure that geometry has a concrete size independent from its owner element
"
Class {
	#name : #BlGeomExactResizer,
	#superclass : #BlGeometryResizer,
	#instVars : [
		'extent'
	],
	#category : #'Bloc-Basic-Support'
}

{ #category : #resizing }
BlGeomExactResizer >> adapt: aGeometry to: anElement [
	aGeometry matchExtent: self extent
]

{ #category : #accessing }
BlGeomExactResizer >> extent [
	^ extent
]

{ #category : #accessing }
BlGeomExactResizer >> extent: aPoint [
	extent := aPoint
]
