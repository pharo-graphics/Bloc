Class {
	#name : #BlFrameLayoutTests,
	#superclass : #TestCase,
	#traits : 'TBlLayoutTests',
	#classTraits : 'TBlLayoutTests classTrait',
	#instVars : [
		'parent'
	],
	#category : 'Bloc-Layout-Tests-Frame'
}

{ #category : #'instance creation' }
BlFrameLayoutTests >> exact: aPoint [
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal exact: aPoint x.
			c vertical exact: aPoint y ];
		yourself
]

{ #category : #'instance creation' }
BlFrameLayoutTests >> exactHeight: aNumber [
	^ BlElement new
		constraintsDo: [ :c |
			c vertical exact: aNumber ];
		yourself
]

{ #category : #'instance creation' }
BlFrameLayoutTests >> exactWidth: aNumber [
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal exact: aNumber ];
		yourself
]

{ #category : #'instance creation' }
BlFrameLayoutTests >> matchParent [
	<gtExample>

	^ BlElement new
		background: Color indexedColors atRandom;
		border: (BlBorder builder paint: Color blue; width: 1; build);
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ];
		yourself
]

{ #category : #'instance creation' }
BlFrameLayoutTests >> matchParent: aWeightPoint [

	^ BlElement new
		background: Color indexedColors atRandom;
		border: (BlBorder builder paint: Color blue; width: 1; build);
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent.
			c frame horizontal weight: aWeightPoint asPoint x.
			c frame vertical weight: aWeightPoint asPoint y ];
		yourself
]

{ #category : #'instance creation' }
BlFrameLayoutTests >> parent [
	<gtExample>

	^ BlElement new
		layout: BlFrameLayout new;
		border: (BlBorder builder dashed; paint: Color red; width: 3; build);
		yourself
]

{ #category : #running }
BlFrameLayoutTests >> setUp [
	super setUp.
	
	parent := BlElement new.
	parent layout: BlFrameLayout new
]

{ #category : #running }
BlFrameLayoutTests >> tearDown [
	super tearDown.
	
	parent := nil
]

{ #category : #tests }
BlFrameLayoutTests >> testOneChildMatchExactParent [
	| child |
	child := self matchParent.
	parent size: 400@300.
	
	parent addChild: child.
	
	parent forceLayout.
	
	self assert: child position equals: 0@0.
	self assert: child extent equals: 400@300.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
]

{ #category : #tests }
BlFrameLayoutTests >> testOneChildMatchExactParentWithPadding [
	<gtExample>
	| aChild aParent |
	
	aChild := self matchParent.
	aParent := self parent.

	aParent size: 400@300.
	aParent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	
	aParent addChild: aChild.
	
	aParent forceLayout.

	self assert: aChild position equals: 40@10.
	self assert: aChild extent equals: 340@260.
	
	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 400@300.
	
	^ aParent
]

{ #category : #tests }
BlFrameLayoutTests >> testOneChildMatchExactParentWithPaddingAndMargin [
	<gtExample>
	| aChild aParent |
	
	aChild := self matchParent.
	aChild margin: (BlInsets top: 40 right: 30 bottom: 20 left: 10).
	
	aParent := self parent.

	aParent size: 400@300.
	aParent padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	
	aParent addChild: aChild.
	
	aParent forceLayout.

	self assert: aChild position equals: 50@50.
	self assert: aChild extent equals: 300@200.
	
	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 400@300.
	
	^ aParent
]

{ #category : #'tests - weight' }
BlFrameLayoutTests >> testOneChildMatchExactParentWithWeight [
	<gtExample>
	| aParent aChild |
	
	aParent := self parent size: 400@300.
	aChild := self matchParent: 0.5 @ 0.4.
	aParent addChild: aChild.
	aParent forceLayout.
	
	self assert: aChild position equals: 0@0.
	self assert: aChild extent equals: 200@120.
	
	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 400@300.
	
	^ aParent
]

{ #category : #'tests - weight' }
BlFrameLayoutTests >> testOneChildMatchExactParentWithWeightAndPadding [
	<gtExample>
	| aChild aParent |
	
	aChild := self matchParent: 0.25 @ 0.5.
	aParent := self parent.

	aParent size: 400@300.
	aParent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	
	aParent addChild: aChild.

	aParent forceLayout.

	self assert: aChild position equals: 40@10.
	self assert: aChild extent equals: 85@130.
	
	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 400@300.
	
	^ aParent
]

{ #category : #'tests - weight' }
BlFrameLayoutTests >> testOneChildMatchExactParentWithWeightAndPaddingAndMargin [
	<gtExample>
	| aChild aParent |
	
	aChild := self matchParent: 0.25 @ 0.5.
	aChild margin: (BlInsets top: 40 right: 30 bottom: 20 left: 10).
	
	aParent := self parent.

	aParent size: 400@300.
	aParent padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	
	aParent addChild: aChild.
	
	aParent forceLayout.

	self assert: aChild position equals: 50@50.
	self assert: aChild extent equals: 75@100.
	
	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 400@300.
	
	^ aParent
]

{ #category : #'tests - alignment' }
BlFrameLayoutTests >> testOneExactChildAlignBottomCenterInExactParent [
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignBottom.

	parent size: 400@300.

	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 150@250.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
]

{ #category : #'tests - alignment' }
BlFrameLayoutTests >> testOneExactChildAlignBottomCenterInExactParentWithPadding [
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignBottom.
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).

	parent size: 400@300.

	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 160@220.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
]

{ #category : #'tests - alignment' }
BlFrameLayoutTests >> testOneExactChildAlignBottomLeftInExactParent [
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignBottom.

	parent size: 400@300.
	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 0@250.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
]

{ #category : #'tests - alignment' }
BlFrameLayoutTests >> testOneExactChildAlignBottomLeftInExactParentWithPadding [
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignBottom.
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).

	parent size: 400@300.
	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 40@220.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
]

{ #category : #'tests - alignment' }
BlFrameLayoutTests >> testOneExactChildAlignBottomRightInExactParent [
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignBottom.

	parent size: 400@300.
	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 300@250.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
]

{ #category : #'tests - alignment' }
BlFrameLayoutTests >> testOneExactChildAlignBottomRightInExactParentWithPadding [
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignBottom.
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).

	parent size: 400@300.
	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 280@220.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
]

{ #category : #'tests - alignment' }
BlFrameLayoutTests >> testOneExactChildAlignCenterInExactParent [
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignCenter.

	parent size: 400@300.
	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 150@125.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
]

{ #category : #'tests - alignment' }
BlFrameLayoutTests >> testOneExactChildAlignCenterInExactParentWithPadding [
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignCenter.
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).

	parent size: 400@300.
	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 160@115.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
]

{ #category : #'tests - alignment' }
BlFrameLayoutTests >> testOneExactChildAlignCenterLeftInExactParent [
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignCenter.

	parent size: 400@300.
	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 0@125.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
]

{ #category : #'tests - alignment' }
BlFrameLayoutTests >> testOneExactChildAlignCenterLeftInExactParentWithPadding [
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignCenter.
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).

	parent size: 400@300.
	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 40@115.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
]

{ #category : #'tests - alignment' }
BlFrameLayoutTests >> testOneExactChildAlignCenterRightInExactParent [
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignCenter.

	parent size: 400@300.
	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 300@125.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
]

{ #category : #'tests - alignment' }
BlFrameLayoutTests >> testOneExactChildAlignCenterRightInExactParentWithPadding [
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignCenter.
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).

	parent size: 400@300.
	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 280@115.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
]

{ #category : #'tests - alignment' }
BlFrameLayoutTests >> testOneExactChildAlignLeftInExactParent [
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignLeft.

	parent size: 400@300.
	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 0@0.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
]

{ #category : #'tests - alignment' }
BlFrameLayoutTests >> testOneExactChildAlignRightInExactParentWithPadding [
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignRight.
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).

	parent size: 400@300.

	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 280@10.
	self assert: child extent equals: 100@50.

	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300
]

{ #category : #'tests - alignment' }
BlFrameLayoutTests >> testOneExactChildAlignTopCenterInExactParent [
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignTop.

	parent size: 400@300.
	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 150@0.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
]

{ #category : #'tests - alignment' }
BlFrameLayoutTests >> testOneExactChildAlignTopCenterInExactParentWithPadding [
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignTop.
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).

	parent size: 400@300.
	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 160@10.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
]

{ #category : #'tests - alignment' }
BlFrameLayoutTests >> testOneExactChildAlignTopLeftInExactParent [
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignTop.

	parent size: 400@300.
	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 0@0.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
]

{ #category : #'tests - alignment' }
BlFrameLayoutTests >> testOneExactChildAlignTopLeftInExactParentWithPadding [
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignTop.
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).

	parent size: 400@300.
	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 40@10.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
]

{ #category : #'tests - alignment' }
BlFrameLayoutTests >> testOneExactChildAlignTopRightInExactParent [
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignTop.

	parent size: 400@300.
	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 300@0.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
]

{ #category : #'tests - alignment' }
BlFrameLayoutTests >> testOneExactChildAlignTopRightInExactParentWithPadding [
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignTop.
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).

	parent size: 400@300.

	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 280@10.
	self assert: child extent equals: 100@50.

	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300
]
