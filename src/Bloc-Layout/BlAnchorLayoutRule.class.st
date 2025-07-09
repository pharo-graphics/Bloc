Class {
	#name : #BlAnchorLayoutRule,
	#superclass : #Object,
	#instVars : [
		'leftHandSideAnchor',
		'rightHandSideAnchor'
	],
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #layout }
BlAnchorLayoutRule >> appliedOnChildBounds: childBoundsRectangle inParent: anElement forChild: aChild [

	leftHandSideAnchor checkInParent: anElement forChild: aChild.
	rightHandSideAnchor checkInParent: anElement forChild: aChild.
	^ anElement globalBoundsToLocal: (leftHandSideAnchor
		  appliedOnRectangle: childBoundsRectangle
		  withValue: (rightHandSideAnchor valueInParent: anElement))
]

{ #category : #accessing }
BlAnchorLayoutRule >> baseAnchor: anAnchor [

	leftHandSideAnchor := anAnchor
]

{ #category : #testing }
BlAnchorLayoutRule >> isMeasurement [ 

	^ leftHandSideAnchor isMeasurement 
]

{ #category : #accessing }
BlAnchorLayoutRule >> leftHHandSideAnchor [

	^ leftHandSideAnchor 
]

{ #category : #accessing }
BlAnchorLayoutRule >> leftHHandSideAnchor: anAnchor [

	leftHandSideAnchor := anAnchor
]

{ #category : #accessing }
BlAnchorLayoutRule >> leftHandSideAnchor [

	^ leftHandSideAnchor 
]

{ #category : #accessing }
BlAnchorLayoutRule >> rightHandSideAnchor: anAnchor [

	rightHandSideAnchor := anAnchor
]
