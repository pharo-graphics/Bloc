"
My position is equal to the top center of a reference element
"
Class {
	#name : #BlElementTopCenterAnchor,
	#superclass : #BlAnchorRelativeToElementBounds,
	#category : 'Bloc-Geometry-Anchors'
}

{ #category : #accessing }
BlElementTopCenterAnchor class >> label [
	^ 'Top center'
]

{ #category : #geometry }
BlElementTopCenterAnchor >> positionWithinBounds: aParentBounds [
	"Compute and return a position of this anchor within provided bounds"
	<return: #Point>

	^ aParentBounds topCenter
]
