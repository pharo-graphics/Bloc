"
My position is equal to the left center of a reference element
"
Class {
	#name : #BlElementCenterLeftAnchor,
	#superclass : #BlAnchorRelativeToElementBounds,
	#category : 'Bloc-Geometry-Anchors'
}

{ #category : #accessing }
BlElementCenterLeftAnchor class >> label [
	^ 'Center left'
]

{ #category : #geometry }
BlElementCenterLeftAnchor >> positionWithinBounds: aParentBounds [
	"Compute and return a position of this anchor within provided bounds"
	<return: #Point>

	^ aParentBounds centerLeft
]
