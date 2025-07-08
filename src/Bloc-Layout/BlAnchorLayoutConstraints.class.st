"
I represent the constraints of a `BlProportionalLayout`.
"
Class {
	#name : #BlAnchorLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'operations'
	],
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #adding }
BlAnchorLayoutConstraints >> add: anAnchorOperation [

	operations add: anAnchorOperation
]

{ #category : #layout }
BlAnchorLayoutConstraints >> applyOperations: anOperationArray inParent: anElement forChild: aChild [

	| bnds |
	bnds := aChild measuredBounds asRectangle.
	anOperationArray do: [ :op |
			bnds := op
				        appliedOnChildBounds: bnds
				        withParent: anElement ].
	^ bnds
]

{ #category : #initialization }
BlAnchorLayoutConstraints >> defaultHorizontal [

	^ BlAnchorLayoutConstraintsHorizontal new
]

{ #category : #initialization }
BlAnchorLayoutConstraints >> defaultVertical [

	^ BlAnchorLayoutConstraintsVertical new
]

{ #category : #initialization }
BlAnchorLayoutConstraints >> initialize [ 

	super initialize.
	operations := OrderedCollection new
]

{ #category : #layout }
BlAnchorLayoutConstraints >> measureInParent: anElement forChild: aChild [

	^ self
		  applyOperations: self measurementOperations
		  inParent: anElement
		  forChild: aChild
]

{ #category : #layout }
BlAnchorLayoutConstraints >> measurementOperations [

	^ operations select: [ :op | op isMeasurement ]
]

{ #category : #layout }
BlAnchorLayoutConstraints >> positionInParent: anElement forChild: aChild [

	^ self
		  applyOperations: self positionOperations
		  inParent: anElement
		  forChild: aChild
]

{ #category : #layout }
BlAnchorLayoutConstraints >> positionOperations [

	^ operations reject: [ :op | op isMeasurement ]
]
