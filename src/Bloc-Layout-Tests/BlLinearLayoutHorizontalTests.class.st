Class {
	#name : #BlLinearLayoutHorizontalTests,
	#superclass : #TestCase,
	#traits : 'TBlLayoutTests',
	#classTraits : 'TBlLayoutTests classTrait',
	#instVars : [
		'parent'
	],
	#category : 'Bloc-Layout-Tests-Linear'
}

{ #category : #'instance creation' }
BlLinearLayoutHorizontalTests >> exact: aPoint [
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal exact: aPoint x.
			c vertical exact: aPoint y ];
		yourself
]

{ #category : #'instance creation' }
BlLinearLayoutHorizontalTests >> exactHeight: aNumber [
	^ BlElement new
		constraintsDo: [ :c |
			c vertical exact: aNumber ];
		yourself
]

{ #category : #'instance creation' }
BlLinearLayoutHorizontalTests >> exactWidth: aNumber [
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal exact: aNumber ];
		yourself
]

{ #category : #'instance creation' }
BlLinearLayoutHorizontalTests >> matchParent [
	^ BlElement new
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ];
		yourself
]

{ #category : #running }
BlLinearLayoutHorizontalTests >> setUp [
	super setUp.
	
	parent := BlElement new.
	parent layout: BlLinearLayout horizontal.
]

{ #category : #running }
BlLinearLayoutHorizontalTests >> tearDown [
	super tearDown.
	
	parent := nil
]

{ #category : #tests }
BlLinearLayoutHorizontalTests >> testOneChildMatchInExactParentPadding [
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
BlLinearLayoutHorizontalTests >> testOneChildMatchOneExactInFitParent [
	"All children are distributed equally within parent's bounds"
	| childA childB |
	childA := self exact: 300@200.
	childB := self exactWidth: 200.
	childB constraints vertical matchParent.

	parent constraints horizontal fitContent.
	parent constraints vertical fitContent.

	parent addChildren: { childA . childB }.

	parent forceLayout.

	self assert: childA extent equals: 300@200.
	self assert: childA position equals: 0@0.

	self assert: childB extent equals: 200@200.
	self assert: childB position equals: 300@0.

	self assert: parent extent equals: 500@200.
	self assert: parent position equals: 0@0
]

{ #category : #tests }
BlLinearLayoutHorizontalTests >> testOneExactChildInExactParentMargin [
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
BlLinearLayoutHorizontalTests >> testThreeMatchChildrenInExactParent [
	"All children are distributed equally within parent's bounds"
	| childA childB childC |
	childA := self matchParent.
	childB := self matchParent.
	childC := self matchParent.
	parent constraints horizontal exact: 600.
	parent constraints vertical exact: 200.

	parent addChildren: { childA . childB . childC }.

	parent forceLayout.

	self assert: childA extent equals: 200@200.
	self assert: childA position equals: 0@0.

	self assert: childB extent equals: 200@200.
	self assert: childB position equals: 200@0.
	
	self assert: childC extent equals: 200@200.
	self assert: childC position equals: 400@0.

	self assert: parent extent equals: 600@200.
	self assert: parent position equals: 0@0
]

{ #category : #tests }
BlLinearLayoutHorizontalTests >> testThreeMatchChildrenInExactParentRTL [
	"All children are distributed equally within parent's bounds"
	| childA childB childC |
	childA := self matchParent.
	childB := self matchParent.
	childC := self matchParent.
	
	parent layout rightToLeft.
	parent constraints horizontal exact: 600.
	parent constraints vertical exact: 200.

	parent addChildren: { childA . childB . childC }.

	parent forceLayout.

	self assert: childC extent equals: 200@200.
	self assert: childC position equals: 0@0.

	self assert: childB extent equals: 200@200.
	self assert: childB position equals: 200@0.
	
	self assert: childA extent equals: 200@200.
	self assert: childA position equals: 400@0.

	self assert: parent extent equals: 600@200.
	self assert: parent position equals: 0@0
]

{ #category : #tests }
BlLinearLayoutHorizontalTests >> testTwoChildrenMatchInExactParentPadding [
	"All children are distributed equally within parent's bounds"
	| childA childB |
	childA := self matchParent.
	childB := self matchParent.

	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 600.
	parent constraints padding: (BlInsets all: 20).

	parent addChildren: { childA . childB }.

	parent forceLayout.

	self assert: childA extent equals: 180@560.
	self assert: childA position equals: 20@20.
	
	self assert: childB extent equals: 180@560.
	self assert: childB position equals: 200@20.

	self assert: parent extent equals: 400@600.
	self assert: parent position equals: 0@0
]

{ #category : #tests }
BlLinearLayoutHorizontalTests >> testTwoExactChildrenInFitContent [
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
	self assert: childB position equals: 200@0.
	
	self assert: parent extent equals: 300@200.
	self assert: parent position equals: 0@0
]

{ #category : #tests }
BlLinearLayoutHorizontalTests >> testTwoMatchChildrenInExactParent [
	"All children are distributed equally within parent's bounds"
	| childA childB |
	childA := self matchParent.
	childB := self matchParent.
	parent constraints horizontal exact: 500.
	parent constraints vertical exact: 200.

	parent addChildren: { childA . childB }.

	parent forceLayout.

	self assert: childA extent equals: 250@200.
	self assert: childA position equals: 0@0.

	self assert: childB extent equals: 250@200.
	self assert: childB position equals: 250@0.

	self assert: parent extent equals: 500@200.
	self assert: parent position equals: 0@0
]
