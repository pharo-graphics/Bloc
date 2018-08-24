"
I find the nearest point that lies on bounds rectangle of a reference element to the center of the given element
"
Class {
	#name : #BlNearestPositionBoundsAnchor,
	#superclass : #BlNearestPositionAnchor,
	#category : 'Bloc-Geometry-Anchors'
}

{ #category : #accessing }
BlNearestPositionBoundsAnchor class >> label [
	^ 'Rectangle'
]

{ #category : #geometry }
BlNearestPositionBoundsAnchor >> globalPositionWithin: aGeometryElement [
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>

	^ self referenceElement boundsInSpace pointNearestTo: self nearestToElement boundsInSpace center
]
