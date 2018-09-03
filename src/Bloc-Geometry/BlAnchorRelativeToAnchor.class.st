"
Anchor relative anchor computes its position based on other anchors
"
Class {
	#name : #BlAnchorRelativeToAnchor,
	#superclass : #BlGeometryAnchor,
	#instVars : [
		'referenceAnchors'
	],
	#category : 'Bloc-Geometry-Anchors'
}

{ #category : #geometry }
BlAnchorRelativeToAnchor >> globalPositionWithin: aGeometryElement [
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>

	^ self subclassResponsibility
]

{ #category : #geometry }
BlAnchorRelativeToAnchor >> positionWithin: aGeometryElement [
	^ self computePositionWithin: aGeometryElement
]

{ #category : #accessing }
BlAnchorRelativeToAnchor >> referenceAnchors [
	<return: #SequenceableCollection of: #BlGeometryAnchor>

	^ referenceAnchors
]

{ #category : #accessing }
BlAnchorRelativeToAnchor >> referenceAnchors: anObject [
	referenceAnchors := anObject
]
