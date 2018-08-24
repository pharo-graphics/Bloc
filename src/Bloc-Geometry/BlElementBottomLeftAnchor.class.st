Class {
	#name : #BlElementBottomLeftAnchor,
	#superclass : #BlAnchorRelativeToElementBounds,
	#category : 'Bloc-Geometry-Anchors'
}

{ #category : #accessing }
BlElementBottomLeftAnchor class >> label [
	^ 'Bottom left'
]

{ #category : #geometry }
BlElementBottomLeftAnchor >> positionWithinBounds: aParentBounds [
	"Compute and return a position of this anchor within provided bounds"
	<return: #Point>

	^ aParentBounds bottomLeft
]
