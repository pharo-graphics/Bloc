"
My position is equal to the right center of a reference element
"
Class {
	#name : #BlElementCenterRightAnchor,
	#superclass : #BlAnchorRelativeToElementBounds,
	#category : 'Bloc-Geometry-Anchors'
}

{ #category : #accessing }
BlElementCenterRightAnchor class >> label [
	^ 'Center right'
]

{ #category : #geometry }
BlElementCenterRightAnchor >> positionWithinBounds: aParentBounds [
	"Compute and return a position of this anchor within provided bounds"
	<return: #Point>

	^ aParentBounds centerRight
]
