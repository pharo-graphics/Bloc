Class {
	#name : #BlElementTopLeftAnchor,
	#superclass : #BlAnchorRelativeToElementBounds,
	#category : 'Bloc-Geometry-Anchors'
}

{ #category : #accessing }
BlElementTopLeftAnchor class >> label [
	^ 'Top left'
]

{ #category : #geometry }
BlElementTopLeftAnchor >> positionWithinBounds: aParentBounds [
	"Compute and return a position of this anchor within provided bounds"
	<return: #Point>

	^ aParentBounds topLeft
]
