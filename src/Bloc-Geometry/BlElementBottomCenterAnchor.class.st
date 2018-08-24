"
My position is equal to the bottom center of a reference element
"
Class {
	#name : #BlElementBottomCenterAnchor,
	#superclass : #BlAnchorRelativeToElementBounds,
	#category : 'Bloc-Geometry-Anchors'
}

{ #category : #accessing }
BlElementBottomCenterAnchor class >> label [
	^ 'Bottom center'
]

{ #category : #geometry }
BlElementBottomCenterAnchor >> positionWithinBounds: aParentBounds [
	"Compute and return a position of this anchor within provided bounds"
	<return: #Point>

	^ aParentBounds bottomCenter
]
