"
I am a root class of geometry elements - elements driven by geometry anchors.
"
Class {
	#name : #BlGeometryElement,
	#superclass : #BlElement,
	#category : #'Bloc-Geometry'
}

{ #category : #layout }
BlGeometryElement >> applyLayoutIn: aBounds [
	super applyLayoutIn: self layoutBounds
]

{ #category : #initialization }
BlGeometryElement >> defaultLayout [
	^ BlGeometryLayout new
]

{ #category : #layout }
BlGeometryElement >> layoutBounds [
	"Compute and return layout bounds based on geometry anchors.
	The bounds origin describes a position of this geometry element
	within its parent, while bounds extent describes my extent"
	<return: #Rectangle>
	
	^ self subclassResponsibility
]

{ #category : #layout }
BlGeometryElement >> measureGeometry [
	"Adapt underlying geometry to fit anchor positions"

	self subclassResponsibility
]

{ #category : #anchors }
BlGeometryElement >> onAnchorMoved [
	"I am sent when any of my anchors moved"
	self requestLayout
]

{ #category : #layout }
BlGeometryElement >> onMeasure: anExtentMeasurementSpec [
	self measureGeometry.
	super onMeasure: anExtentMeasurementSpec
]

{ #category : #anchors }
BlGeometryElement >> registerAnchor: aGeometryAnchor [
	"Register a given geometry anchor as one of my anchors"
	aGeometryAnchor attachTo: self
]

{ #category : #anchors }
BlGeometryElement >> unregisterAnchor: aGeometryAnchor [
	"Unregister a given geometry anchor from being one of my anchors"
	aGeometryAnchor detachFrom: self
]
