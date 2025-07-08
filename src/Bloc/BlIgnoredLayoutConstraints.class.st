Class {
	#name : #BlIgnoredLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'anchors'
	],
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #accessing }
BlIgnoredLayoutConstraints >> addAnchor: anAnchorOperation [

	self anchors add: anAnchorOperation
]

{ #category : #accessing }
BlIgnoredLayoutConstraints >> alignment [
	^ self horizontal alignment + self vertical alignment
]

{ #category : #accessing }
BlIgnoredLayoutConstraints >> anchors [ 

	^ anchors ifNil: [ anchors := OrderedCollection new ]
]

{ #category : #anchoring }
BlIgnoredLayoutConstraints >> applyAnchorOperations: anOperationArray inParent: anElement forChild: aChild [

	| bnds |
	bnds := aChild measuredBounds asRectangle.
	anOperationArray do: [ :op |
			bnds := op
				        appliedOnChildBounds: bnds
				        withParent: anElement ].
	^ bnds
]

{ #category : #initialization }
BlIgnoredLayoutConstraints >> defaultHorizontal [
	^ BlIgnoredLayoutConstraintsHorizontal new
]

{ #category : #initialization }
BlIgnoredLayoutConstraints >> defaultVertical [
	^ BlIgnoredLayoutConstraintsVertical new
]

{ #category : #anchoring }
BlIgnoredLayoutConstraints >> measureWithAnchorsInParent: anElement forChild: aChild [

	^ self
		  applyAnchorOperations: (self measurementOperationsForChild: aChild)
		  inParent: anElement
		  forChild: aChild
]

{ #category : #layout }
BlIgnoredLayoutConstraints >> measurementOperationsForChild: aChild [

	^ self anchors select: [ :op |
		  op leftHandSideAnchor element = aChild and: [ op isMeasurement ] ]
]

{ #category : #layout }
BlIgnoredLayoutConstraints >> positionOperationsForChild: aChild [

	^ self anchors reject: [ :op | op leftHandSideAnchor element ~= aChild or: [  op isMeasurement ] ]
]

{ #category : #anchoring }
BlIgnoredLayoutConstraints >> positionWithAnchorsInParent: anElement forChild: aChild [

	^ self
		  applyAnchorOperations: (self positionOperationsForChild: aChild)
		  inParent: anElement
		  forChild: aChild
]
