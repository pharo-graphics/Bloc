"
My position is equal to the center of a reference element
"
Class {
	#name : #BlElementCenterAnchor,
	#superclass : #BlAnchorRelativeToElementBounds,
	#category : 'Bloc-Geometry-Anchors'
}

{ #category : #accessing }
BlElementCenterAnchor class >> label [
	^ 'Center'
]

{ #category : #geometry }
BlElementCenterAnchor >> positionWithinBounds: aParentBounds [
	"Compute and return a position of this anchor within provided bounds"
	<return: #Point>

	^ aParentBounds center
]
