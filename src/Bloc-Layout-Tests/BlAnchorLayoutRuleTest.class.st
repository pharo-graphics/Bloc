"
A BlAnchorLayoutRuleTest is a test class for testing the behavior of BlAnchorLayoutRule
"
Class {
	#name : #BlAnchorLayoutRuleTest,
	#superclass : #TestCase,
	#category : #'Bloc-Layout-Tests-Anchor'
}

{ #category : #tests }
BlAnchorLayoutRuleTest >> testAppliedOnChildBoundsInParentForChild [

	| parent child rule resultBounds |
	parent := BlElement new.
	child := BlElement new.
	parent extent: 70 @ 70.
	child extent: 30 @ 30.
	parent addChild: child.
	rule := BlAnchorLayoutRule new.
	rule baseAnchor: child extentAnchor.
	rule rightHandSideAnchor: parent extentAnchor.
	parent forceLayout.
	child forceLayout.
	resultBounds := rule
		                appliedOnChildBounds: (0 @ 0 extent: 10 @ 10)
		                inParent: parent
		                forChild: child.
	self
		assert: parent measuredBounds asRectangle
		equals: (0.0 @ 0.0 extent: 70 @ 70 ).
	self
		assert: child measuredBounds asRectangle
		equals: (0.0 @ 0.0 extent: 30 @ 30 ).
	self assert: resultBounds equals: (0 @ 0 extent: 70 @ 70)
]

{ #category : #tests }
BlAnchorLayoutRuleTest >> testIsMeasurement [

	| parent child rule |
	parent := BlElement new.
	child := BlElement new.
	parent addChild: child.
	rule := BlAnchorLayoutRule new.
	rule baseAnchor: child extentAnchor.
	rule rightHandSideAnchor: parent extentAnchor.
	self assert: rule isMeasurement 
	
]

{ #category : #tests }
BlAnchorLayoutRuleTest >> testIsMeasurement2 [

	| parent child rule |
	parent := BlElement new.
	child := BlElement new.
	parent addChild: child.
	rule := BlAnchorLayoutRule new.
	rule baseAnchor: child bottomAnchor.
	rule rightHandSideAnchor: parent topAnchor.
	self deny: rule isMeasurement 
	
]
