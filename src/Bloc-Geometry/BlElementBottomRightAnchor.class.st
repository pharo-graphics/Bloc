Class {
	#name : #BlElementBottomRightAnchor,
	#superclass : #BlAnchorRelativeToElementBounds,
	#category : 'Bloc-Geometry-Anchors'
}

{ #category : #accessing }
BlElementBottomRightAnchor class >> label [
	^ 'Bottom right'
]

{ #category : #geometry }
BlElementBottomRightAnchor >> positionWithinBounds: aParentBounds [
	"Compute and return a position of this anchor within provided bounds"
	<return: #Point>

	^ aParentBounds bottomRight
]
