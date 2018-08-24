Class {
	#name : #BlLinearLayoutVerticalTests,
	#superclass : #TestCase,
	#traits : 'TBlLayoutTests',
	#classTraits : 'TBlLayoutTests classTrait',
	#instVars : [
		'parent'
	],
	#category : 'Bloc-Layout-Tests-Linear'
}

{ #category : #'instance creation' }
BlLinearLayoutVerticalTests >> exact: aPoint [
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal exact: aPoint x.
			c vertical exact: aPoint y ];
		yourself
]

{ #category : #'instance creation' }
BlLinearLayoutVerticalTests >> exactHeight: aNumber [
	^ BlElement new
		constraintsDo: [ :c |
			c vertical exact: aNumber ];
		yourself
]

{ #category : #'instance creation' }
BlLinearLayoutVerticalTests >> exactWidth: aNumber [
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal exact: aNumber ];
		yourself
]

{ #category : #'instance creation' }
BlLinearLayoutVerticalTests >> matchParent [
	^ BlElement new
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ];
		yourself
]

{ #category : #running }
BlLinearLayoutVerticalTests >> setUp [
	super setUp.
	
	parent := BlElement new.
	parent layout: BlLinearLayout vertical.
]

{ #category : #running }
BlLinearLayoutVerticalTests >> tearDown [
	super tearDown.
	
	parent := nil
]

{ #category : #tests }
BlLinearLayoutVerticalTests >> testOneChildMatchInExactParentPadding [
	"All children are distributed equally within parent's bounds"
	| childA |
	childA := self matchParent.

	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 600.
	parent constraints padding: (BlInsets all: 20).

	parent addChildren: { childA }.

	parent forceLayout.

	self assert: childA extent equals: 360@560.
	self assert: childA position equals: 20@20.

	self assert: parent extent equals: 400@600.
	self assert: parent position equals: 0@0
]

{ #category : #tests }
BlLinearLayoutVerticalTests >> testOneChildMatchOneExactInFitParent [
	"All children are distributed equally within parent's bounds"
	| childA childB |
	childA := self exact: 200@300.
	childB := self exactHeight: 200.
	childB constraints horizontal matchParent.

	parent constraints horizontal fitContent.
	parent constraints vertical fitContent.

	parent addChildren: { childA . childB }.

	parent forceLayout.

	self assert: childA extent equals: 200@300.
	self assert: childA position equals: 0@0.

	self assert: childB extent equals: 200@200.
	self assert: childB position equals: 0@300.

	self assert: parent extent equals: 200@500.
	self assert: parent position equals: 0@0
]

{ #category : #tests }
BlLinearLayoutVerticalTests >> testOneExactChildInExactParentMargin [
	"All children are distributed equally within parent's bounds"
	| childA |
	childA := self exact: 20@20.
	childA margin: (BlInsets top: 15 right: 0 bottom: 0 left: 10).
	
	parent constraints horizontal exact: 50.
	parent constraints vertical exact: 50.

	parent addChildren: { childA }.

	parent forceLayout.

	self assert: childA extent equals: 20@20.
	self assert: childA position equals: 10@15.

	self assert: parent extent equals: 50@50.
	self assert: parent position equals: 0@0
]

{ #category : #tests }
BlLinearLayoutVerticalTests >> testThreeExactChildrenAlignInExactParentLTR [
	| childA childB childC |
	childA := self exact: 100@100.
	childB := self exact: 200@100.
	childC := self exact: 50@100.
	
	childA constraints linear horizontal alignLeft.
	childB constraints linear horizontal alignCenter.
	childC constraints linear horizontal alignRight.
	
	parent constraints horizontal exact: 500.
	parent constraints vertical exact: 600.
	
	parent addChildren: { childA . childB . childC }.

	parent forceLayout.

	self assert: childA extent equals: 100@100.
	self assert: childA position equals: 0@0.

	self assert: childB extent equals: 200@100.
	self assert: childB position equals: 150@100.
	
	self assert: childC extent equals: 50@100.
	self assert: childC position equals: 450@200.

	self assert: parent extent equals: 500@600.
	self assert: parent position equals: 0@0
]

{ #category : #tests }
BlLinearLayoutVerticalTests >> testThreeExactChildrenAlignInExactParentRTL [
	| childA childB childC |
	childA := self exact: 100@100.
	childB := self exact: 200@100.
	childC := self exact: 50@100.
	
	childA constraints linear horizontal alignLeft.
	childB constraints linear horizontal alignCenter.
	childC constraints linear horizontal alignRight.
	
	parent layout rightToLeft.
	parent constraints horizontal exact: 500.
	parent constraints vertical exact: 600.
	
	parent addChildren: { childA . childB . childC }.

	parent forceLayout.

	self assert: childA extent equals: 100@100.
	self assert: childA position equals: 400@0.

	self assert: childB extent equals: 200@100.
	self assert: childB position equals: 150@100.
	
	self assert: childC extent equals: 50@100.
	self assert: childC position equals: 0@200.

	self assert: parent extent equals: 500@600.
	self assert: parent position equals: 0@0
]

{ #category : #tests }
BlLinearLayoutVerticalTests >> testThreeMatchChildrenInExactParent [
	"All children are distributed equally within parent's bounds"
	| childA childB childC |
	childA := self matchParent.
	childB := self matchParent.
	childC := self matchParent.
	parent constraints horizontal exact: 200.
	parent constraints vertical exact: 600.

	parent addChildren: { childA . childB . childC }.

	parent forceLayout.

	self assert: childA extent equals: 200@200.
	self assert: childA position equals: 0@0.

	self assert: childB extent equals: 200@200.
	self assert: childB position equals: 0@200.
	
	self assert: childC extent equals: 200@200.
	self assert: childC position equals: 0@400.

	self assert: parent extent equals: 200@600.
	self assert: parent position equals: 0@0
]

{ #category : #tests }
BlLinearLayoutVerticalTests >> testTwoChildrenMatchInExactParentPadding [
	"All children are distributed equally within parent's bounds"
	| childA childB |
	childA := self matchParent.
	childB := self matchParent.

	parent constraints horizontal exact: 600.
	parent constraints vertical exact: 400.
	parent constraints padding: (BlInsets all: 20).

	parent addChildren: { childA . childB }.

	parent forceLayout.

	self assert: childA extent equals: 560@180.
	self assert: childA position equals: 20@20.
	
	self assert: childB extent equals: 560@180.
	self assert: childB position equals: 20@200.

	self assert: parent extent equals: 600@400.
	self assert: parent position equals: 0@0
]

{ #category : #tests }
BlLinearLayoutVerticalTests >> testTwoExactChildrenInFitContent [
	"Parent resizes to fit children"
	| childA childB |
	childA := self exact: 200@100.
	childB := self exact: 100@200.
	parent constraints horizontal fitContent.
	parent constraints vertical fitContent.
	
	parent addChildren: { childA . childB }.
	
	parent forceLayout.
	
	self assert: childA extent equals: 200@100.
	self assert: childA position equals: 0@0.
	
	self assert: childB extent equals: 100@200.
	self assert: childB position equals: 0@100.
	
	self assert: parent extent equals: 200@300.
	self assert: parent position equals: 0@0
]

{ #category : #tests }
BlLinearLayoutVerticalTests >> testTwoMatchChildrenInExactParent [
	"All children are distributed equally within parent's bounds"
	| childA childB |
	childA := self matchParent.
	childB := self matchParent.
	parent constraints horizontal exact: 200.
	parent constraints vertical exact: 500.

	parent addChildren: { childA . childB }.

	parent forceLayout.

	self assert: childA extent equals: 200@250.
	self assert: childA position equals: 0@0.

	self assert: childB extent equals: 200@250.
	self assert: childB position equals: 0@250.

	self assert: parent extent equals: 200@500.
	self assert: parent position equals: 0@0
]
