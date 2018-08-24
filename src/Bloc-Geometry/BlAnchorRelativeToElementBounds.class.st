Class {
	#name : #BlAnchorRelativeToElementBounds,
	#superclass : #BlAnchorRelativeToElement,
	#category : 'Bloc-Geometry-Anchors'
}

{ #category : #geometry }
BlAnchorRelativeToElementBounds >> computePositionWithin: aGeometryElement [
	"Compute and return a position of this anchor in parent coordinates of the *anchor* element
	taking into account a given geometry element"
	<return: #Point>

	^ aGeometryElement
		firstCommonParent: self referenceElement
		ifFound: [ :aCommonParent | self positionWithinBounds: ((self referenceElement bounds inParent: aCommonParent) inChild: aGeometryElement) inParent ]
		ifNone: [ 0@0 ]
]

{ #category : #geometry }
BlAnchorRelativeToElementBounds >> globalPositionWithin: aGeometryElement [
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>

	^ self positionWithinBounds: self referenceElement bounds inSpace
]

{ #category : #geometry }
BlAnchorRelativeToElementBounds >> positionWithinBounds: aParentBounds [
	"Compute and return a position of this anchor within provided bounds"
	<return: #Point>

	^ self subclassResponsibility
]
