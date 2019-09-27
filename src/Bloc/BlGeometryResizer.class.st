"
I am an abstract geometry resizer.
My main responsibility is to adapt geometry path to element's size.

Every time element's size changes I adapt a given geometry path to an element.
My subclasses must implement adapt:to:
"
Class {
	#name : #BlGeometryResizer,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Basic-Support'
}

{ #category : #'instance creation' }
BlGeometryResizer class >> exact: anExtent [
	"Return an instance of exact geometry resizer for a given extent as a point.
	anExtent must not be nil"
	<return: #BlGeometryResizer>
	
	^ BlGeomExactResizer extent: anExtent
]

{ #category : #'instance creation' }
BlGeometryResizer class >> match [
	"Return an instance of resizer that makes geometry be as big as owner element"
	<return: #BlGeometryResizer>

	^ BlGeomMatchResizer uniqueInstance
]

{ #category : #resizing }
BlGeometryResizer >> adapt: aGeometry to: anElement [
	self subclassResponsibility
]
