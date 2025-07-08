Class {
	#name : #BlAnchorLayoutOperation,
	#superclass : #Object,
	#instVars : [
		'leftHandSideAnchor',
		'rightHandSideAnchor'
	],
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #layout }
BlAnchorLayoutOperation >> appliedOnChildBounds: childBoundsRectangle withParent: anElement [

	^ anElement globalBoundsToLocal: (leftHandSideAnchor
		  appliedOnRectangle: childBoundsRectangle
		  withValue: (rightHandSideAnchor valueInParent: anElement))
]

{ #category : #accessing }
BlAnchorLayoutOperation >> baseAnchor: anAnchor [

	leftHandSideAnchor := anAnchor
]

{ #category : #testing }
BlAnchorLayoutOperation >> isMeasurement [ 

	^ leftHandSideAnchor isMeasurement 
]

{ #category : #accessing }
BlAnchorLayoutOperation >> leftHHandSideAnchor [

	^ leftHandSideAnchor 
]

{ #category : #accessing }
BlAnchorLayoutOperation >> leftHandSideAnchor [

	^ leftHandSideAnchor 
]

{ #category : #accessing }
BlAnchorLayoutOperation >> rightHandSideAnchor: anAnchor [

	rightHandSideAnchor := anAnchor
]
