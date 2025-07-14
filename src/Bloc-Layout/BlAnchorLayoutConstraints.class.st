"
I represent the constraints of a `BlProportionalLayout`.
"
Class {
	#name : #BlAnchorLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'rules'
	],
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #'layout anchors' }
BlAnchorLayoutConstraints >> actionAnchor: aBlock [

	^ BlAnchorChildReceiver new actionAnchor: aBlock
]

{ #category : #adding }
BlAnchorLayoutConstraints >> add: anAnchorRule [

	rules add: anAnchorRule
]

{ #category : #layout }
BlAnchorLayoutConstraints >> applyRules: aRuleArray inParent: anElement forChild: aChild [

	| bnds |
	bnds := (aChild geometry anchorLayoutBoundsOfElement: aChild) asRectangle.
	aRuleArray do: [ :op |
			bnds := op
				        appliedOnChildBounds: bnds
				        inParent: anElement
				        forChild: aChild ].
	^ bnds
]

{ #category : #'layout anchors' }
BlAnchorLayoutConstraints >> bottomAnchor [

	^ BlAnchorChildReceiver new bottomAnchor
]

{ #category : #'layout anchors' }
BlAnchorLayoutConstraints >> bottomLeftAnchor [

	^ BlAnchorChildReceiver new bottomLeftAnchor
]

{ #category : #'layout anchors' }
BlAnchorLayoutConstraints >> bottomRightAnchor [

	^ BlAnchorChildReceiver new bottomRightAnchor
]

{ #category : #'layout anchors' }
BlAnchorLayoutConstraints >> centerAnchor [

	^ BlAnchorChildReceiver new centerAnchor
]

{ #category : #layout }
BlAnchorLayoutConstraints >> child [ 

	^ BlAnchorChildReceiver new
]

{ #category : #initialization }
BlAnchorLayoutConstraints >> defaultHorizontal [

	^ BlAnchorLayoutConstraintsHorizontal new
]

{ #category : #initialization }
BlAnchorLayoutConstraints >> defaultVertical [

	^ BlAnchorLayoutConstraintsVertical new
]

{ #category : #'layout anchors' }
BlAnchorLayoutConstraints >> extentAnchor [

	^ BlAnchorChildReceiver new extentAnchor
]

{ #category : #'layout anchors' }
BlAnchorLayoutConstraints >> heightAnchor [

	^ BlAnchorChildReceiver new heightAnchor
]

{ #category : #'layout anchors' }
BlAnchorLayoutConstraints >> horizontalCenterAnchor [

	^ BlAnchorChildReceiver new horizontalCenterAnchor
]

{ #category : #initialization }
BlAnchorLayoutConstraints >> initialize [ 

	super initialize.
	rules := OrderedCollection new
]

{ #category : #'layout anchors' }
BlAnchorLayoutConstraints >> leftAnchor [

	^ BlAnchorChildReceiver new leftAnchor
]

{ #category : #layout }
BlAnchorLayoutConstraints >> measureInParent: anElement forChild: aChild [

	^ self
		  applyRules: self measurementRules
		  inParent: anElement
		  forChild: aChild
]

{ #category : #layout }
BlAnchorLayoutConstraints >> measurementRules [

	^ rules select: [ :op | op isMeasurement ]
]

{ #category : #'layout anchors' }
BlAnchorLayoutConstraints >> neutralAnchor: aNeutralValue [

	^ BlAnchorChildReceiver new 
		  neutralAnchor: aNeutralValue
]

{ #category : #layout }
BlAnchorLayoutConstraints >> newExplicitReceiverWith: anElement [

	^ BlAnchorExplicitReceiver element: anElement
]

{ #category : #'layout anchors' }
BlAnchorLayoutConstraints >> nilAnchor [

	^ BlAnchorChildReceiver new nilAnchor
]

{ #category : #layout }
BlAnchorLayoutConstraints >> parent [ 

	^ BlAnchorParentReceiver new
]

{ #category : #'layout anchors' }
BlAnchorLayoutConstraints >> perimeterAnchor [

	^ BlAnchorChildReceiver new perimeterAnchor
]

{ #category : #'layout anchors' }
BlAnchorLayoutConstraints >> pointAnchor [ 

	^ BlAnchorChildReceiver new pointAnchor
]

{ #category : #layout }
BlAnchorLayoutConstraints >> positionInParent: anElement forChild: aChild [

	^ self
		  applyRules: self positionRules
		  inParent: anElement
		  forChild: aChild
]

{ #category : #layout }
BlAnchorLayoutConstraints >> positionRules [

	^ rules reject: [ :op | op isMeasurement ]
]

{ #category : #'layout anchors' }
BlAnchorLayoutConstraints >> rightAnchor [

	^ BlAnchorChildReceiver new rightAnchor
]

{ #category : #'layout anchors' }
BlAnchorLayoutConstraints >> topAnchor [

	^ BlAnchorChildReceiver new topAnchor
]

{ #category : #'layout anchors' }
BlAnchorLayoutConstraints >> topLeftAnchor [

	^ BlAnchorChildReceiver new topLeftAnchor
]

{ #category : #'layout anchors' }
BlAnchorLayoutConstraints >> topRightAnchor [

	^ BlAnchorChildReceiver new topRightAnchor
]

{ #category : #'layout anchors' }
BlAnchorLayoutConstraints >> verticalCenterAnchor [

	^ BlAnchorChildReceiver new verticalCenterAnchor
]

{ #category : #'layout anchors' }
BlAnchorLayoutConstraints >> widthAnchor [

	^ BlAnchorChildReceiver new widthAnchor
]
