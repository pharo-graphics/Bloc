"
I have been automatically converted and probably manually tweaked from BlFrameLayoutSingleChildExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlFrameLayoutSingleChildTest,
	#superclass : #BlFrameLayoutChildrenTest,
	#category : #'Bloc-Layout-Tests'
}

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testChildElementMatchingParentWith25per50Percent [

	<sampleInstance>
	<demo>
	| element |
	element := self testChildElementWithVisualProperties.
	element constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent.
		c frame horizontal weight: 0.25.
		c frame vertical weight: 0.5 ].
	self assert: element position equals: 0 @ 0.
	self assert: element extent equals: 0 @ 0.
	self assert: element constraints horizontal resizer isMatchParent.
	self assert: element constraints vertical resizer isMatchParent.
	self assert: element constraints frame horizontal weight equals: 0.25.
	self assert: element constraints frame vertical weight equals: 0.5.
	^ element
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testChildElementMatchingParentWith50per40Percent [

	<sampleInstance>
	<demo>
	| element |
	element := self testChildElementWithVisualProperties.
	element constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent.
		c frame horizontal weight: 0.5.
		c frame vertical weight: 0.4 ].
	self assert: element position equals: 0 @ 0.
	self assert: element extent equals: 0 @ 0.
	self assert: element constraints horizontal resizer isMatchParent.
	self assert: element constraints vertical resizer isMatchParent.
	self assert: element constraints frame horizontal weight equals: 0.5.
	self assert: element constraints frame vertical weight equals: 0.4.
	^ element
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testChildElementMatchingWidthFitHeight [

	<sampleInstance>
	<demo>
	| element |
	element := self testChildElementWithVisualProperties.
	element constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	self assert: element position equals: 0 @ 0.
	self assert: element extent equals: 0 @ 0.
	self assert: element constraints horizontal resizer isMatchParent.
	self assert: element constraints vertical resizer isFitContent.
	self assert: element constraints frame horizontal weight equals: 1.0.
	self assert: element constraints frame vertical weight equals: 1.0.
	^ element
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testChildElementMatchingWidthFitLimitedHeight [

	<sampleInstance>
	<demo>
	| element |
	element := self testChildElementWithVisualProperties.
	element constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContentLimited ].
	self assert: element position equals: 0 @ 0.
	self assert: element extent equals: 0 @ 0.
	self assert: element constraints horizontal resizer isMatchParent.
	self assert: element constraints vertical resizer isFitContent.
	self assert: element constraints frame horizontal weight equals: 1.0.
	self assert: element constraints frame vertical weight equals: 1.0.
	^ element
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testEelementWithMaxWidthOneChildMatchExactParent [

	<sampleInstance>
	<demo>
	| child aParent |
	child := self testChildElementMatchingParent.
	aParent := self testParentWithFrameLayoutAndFixedExtent.
	aParent constraintsDo: [ :c | c maxWidth: 200 ].
	aParent addChild: child.
	aParent forceLayout.
	self assert: child position equals: 0 @ 0.
	self assert: child extent equals: 200 @ 300.
	self assert: aParent position equals: 0 @ 0.
	self assert: aParent extent equals: 200 @ 300.
	^ aParent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementDocumentationWithOneExactChildAlignBottomRightInExactParent [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithVisualProperties.
	child constraintsDo: [ :c |
		c horizontal exact: 140.
		c vertical exact: 140.
		c frame horizontal alignRight.
		c frame vertical alignBottom ].
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent extent: 300 @ 300.
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 160 @ 160.
	self assert: child extent equals: 140 @ 140.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 300 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementForDocumentationWithOneChildMatchExactParentWithWeight [

	<sampleInstance>
	<demo>
	| parent child |
	child := self testChildElementWithVisualProperties.
	child constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent.
		c frame horizontal weight: 0.9.
		c frame vertical weight: 0.5 ].
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 0 @ 0.
	self assert: child extent equals: 360 @ 150.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithMaxHeightOneChildMatchExactParent [

	<sampleInstance>
	<demo>
	| child aParent |
	child := self testChildElementMatchingParent.
	aParent := self testParentWithFrameLayoutAndFixedExtent.
	aParent constraintsDo: [ :c | c maxHeight: 200 ].
	aParent addChild: child.
	aParent forceLayout.
	self assert: child position equals: 0 @ 0.
	self assert: child extent equals: 400 @ 200.
	self assert: aParent position equals: 0 @ 0.
	self assert: aParent extent equals: 400 @ 200.
	^ aParent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithMaxWidthOneChildMatchExactParent [

	<sampleInstance>
	<demo>
	| child aParent |
	child := self testChildElementMatchingParent.
	aParent := self testParentWithFrameLayoutAndFixedExtent.
	aParent constraintsDo: [ :c | c maxWidth: 200 ].
	aParent addChild: child.
	aParent forceLayout.
	self assert: child position equals: 0 @ 0.
	" since child is matchParent"
	self assert: child extent equals: 200 @ 300.
	self assert: aParent position equals: 0 @ 0.
	" width is 200 according to c maxWidth: 200 "
	self assert: aParent extent equals: 200 @ 300.
	^ aParent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithMinAndMaxHeightOneChildMatchExactParent [

	<sampleInstance>
	<demo>
	| child aParent |
	child := self testChildElementMatchingParent.
	aParent := self testParentWithFrameLayoutAndFixedExtent.
	aParent constraintsDo: [ :c |
		c maxHeight: 200.
		c minHeight: 500 ]. "minHeight has a precedence over maxHeight"
	aParent addChild: child.
	aParent forceLayout.
	self assert: child position equals: 0 @ 0.
	self assert: child extent equals: 400 @ 500.
	self assert: aParent position equals: 0 @ 0.
	self assert: aParent extent equals: 400 @ 500.
	^ aParent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithMinAndMaxWidthOneChildMatchExactParent [

	<sampleInstance>
	<demo>
	| child aParent |
	child := self testChildElementMatchingParent.
	aParent := self testParentWithFrameLayoutAndFixedExtent.
	aParent constraintsDo: [ :c |
		c maxWidth: 200.
		c minWidth: 500 ]. "minWidth has a precedence over maxWidth"
	aParent addChild: child.
	aParent forceLayout.
	self assert: child position equals: 0 @ 0.
	self assert: child extent equals: 500 @ 300.
	self assert: aParent position equals: 0 @ 0.
	self assert: aParent extent equals: 500 @ 300.
	^ aParent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithMinHeightOneChildMatchExactParent [

	<sampleInstance>
	<demo>
	| child aParent |
	child := self testChildElementMatchingParent.
	aParent := self testParentWithFrameLayoutAndFixedExtent.
	aParent constraintsDo: [ :c | c minHeight: 500 ].
	aParent addChild: child.
	aParent forceLayout.
	self assert: child position equals: 0 @ 0.
	self assert: child extent equals: 400 @ 500.
	self assert: aParent position equals: 0 @ 0.
	self assert: aParent extent equals: 400 @ 500.
	^ aParent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithMinWidthOneChildMatchExactParent [

	<sampleInstance>
	<demo>
	| child aParent |
	child := self testChildElementMatchingParent.
	aParent := self testParentWithFrameLayoutAndFixedExtent.
	aParent constraintsDo: [ :c | c minWidth: 500 ].
	aParent addChild: child.
	aParent forceLayout.
	self assert: child position equals: 0 @ 0.
	self assert: child extent equals: 500 @ 300.
	self assert: aParent position equals: 0 @ 0.
	self assert: aParent extent equals: 500 @ 300.
	^ aParent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneChildMatchExactParent [

	<sampleInstance>
	<demo>
	| child aParent |
	child := self testChildElementMatchingParent.
	aParent := self testParentWithFrameLayoutAndFixedExtent.
	aParent addChild: child.
	aParent forceLayout.
	self assert: child position equals: 0 @ 0.
	self assert: child extent equals: 400 @ 300.
	self assert: aParent position equals: 0 @ 0.
	self assert: aParent extent equals: 400 @ 300.
	^ aParent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneChildMatchExactParentWithPadding [

	<sampleInstance>
	<demo>
	| aChild aParent |
	aChild := self testChildElementWithVisualProperties.
	aChild constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent ].
	aParent := self testParentWithFrameLayoutAndFixedExtent.
	aParent constraints padding: (BlInsets
			 top: 10
			 right: 20
			 bottom: 30
			 left: 40).
	aParent addChild: aChild.
	aParent forceLayout.
	self assert: aChild position equals: 40 @ 10.
	self assert: aChild extent equals: 340 @ 260.
	self assert: aParent position equals: 0 @ 0.
	self assert: aParent extent equals: 400 @ 300.
	^ aParent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneChildMatchExactParentWithPaddingAndMargin [

	<sampleInstance>
	<demo>
	| aChild aParent |
	aChild := self testChildElementWithVisualProperties.
	aChild constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent ].
	aChild margin: (BlInsets
			 top: 40
			 right: 30
			 bottom: 20
			 left: 10).
	aParent := self testParentWithFrameLayoutAndFixedExtent.
	aParent padding: (BlInsets
			 top: 10
			 right: 20
			 bottom: 30
			 left: 40).
	aParent addChild: aChild.
	aParent forceLayout.
	self assert: aChild position equals: 50 @ 50.
	self assert: aChild extent equals: 300 @ 200.
	self assert: aParent position equals: 0 @ 0.
	self assert: aParent extent equals: 400 @ 300.
	^ aParent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneChildMatchExactParentWithWeight [

	<sampleInstance>
	<demo>
	| parent child |
	child := self testChildElementMatchingParentWith50per40Percent.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 0 @ 0.
	self assert: child extent equals: 200 @ 120.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneChildMatchExactParentWithWeightAndPadding [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementMatchingParentWith25per50Percent.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent constraints padding: (BlInsets
			 top: 10
			 right: 20
			 bottom: 30
			 left: 40).
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 40 @ 10.
	self assert: child extent equals: 85 @ 130.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneChildMatchExactParentWithWeightAndPaddingAndMargin [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementMatchingParentWith25per50Percent.
	child margin: (BlInsets
			 top: 40
			 right: 30
			 bottom: 20
			 left: 10).
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent padding: (BlInsets
			 top: 10
			 right: 20
			 bottom: 30
			 left: 40).
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 50 @ 50.
	self assert: child extent equals: 75 @ 100.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneChildMatchWidthFitHeightParentExactWidthFitHeight [

	<sampleInstance>
	<demo>
	| parent child subChild |
	subChild := self testChildElementWithVisualProperties.
	subChild constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical exact: 300 ].
	child := self testChildElementMatchingWidthFitHeight.
	child layout: BlLinearLayout horizontal.
	child addChild: subChild.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent constraintsDo: [ :c | c vertical fitContent ].
	parent addChild: child.
	parent forceLayout.
	self assert: subChild position equals: 0 @ 0.
	self assert: subChild extent equals: 300 @ 300.
	self assert: child position equals: 0 @ 0.
	self assert: child extent equals: 400 @ 300.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneChildMatchWidthFitLimitedHeightParentExactWidthFitHeight [

	<sampleInstance>
	<demo>
	| parent child subChild |
	subChild := self testChildElementWithVisualProperties.
	subChild constraintsDo: [ :c |
		c horizontal exact: 500.
		c vertical exact: 500 ].

	"the child's width should be 400, while height is limited to parent's height (300)"
	child := self testChildElementMatchingWidthFitLimitedHeight.
	child layout: BlLinearLayout horizontal.
	child addChild: subChild.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent addChild: child.
	parent forceLayout.
	self assert: subChild position equals: 0 @ 0.
	self assert: subChild extent equals: 500 @ 500.
	self assert: child position equals: 0 @ 0.
	self assert: child extent equals: 400 @ 300.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneChildWithExactSizeParentWithWeight [

	<sampleInstance>
	<demo>
	| parent child |
	child := self testChildElementWithVisualProperties.
	child constraintsDo: [ :c |
		c horizontal exact: 140.
		c vertical exact: 140.
		c frame horizontal weight: 0.9.
		c frame vertical weight: 0.5 ].
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 0 @ 0.
	self assert: child extent equals: 140 @ 140.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAlignBottomCenterAndWithWeightInExactParent [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithExactExtent100per50.
	child constraintsDo: [ :c |
		c frame horizontal weight: 0.9.
		c frame vertical weight: 0.5.
		c frame horizontal alignCenter.
		c frame vertical alignBottom ].
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 150 @ 250.
	self assert: child extent equals: 100 @ 50.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAlignBottomCenterInExactParent [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithExactExtent100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignBottom.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 150 @ 250.
	self assert: child extent equals: 100 @ 50.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAlignBottomCenterInExactParentWithPadding [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithExactExtent100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignBottom.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent constraints padding: (BlInsets
			 top: 10
			 right: 20
			 bottom: 30
			 left: 40).
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 160 @ 220.
	self assert: child extent equals: 100 @ 50.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAlignBottomLeftInExactParent [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithExactExtent100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignBottom.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 0 @ 250.
	self assert: child extent equals: 100 @ 50.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAlignBottomLeftInExactParentWithPadding [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithExactExtent100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignBottom.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent constraints padding: (BlInsets
			 top: 10
			 right: 20
			 bottom: 30
			 left: 40).
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 40 @ 220.
	self assert: child extent equals: 100 @ 50.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAlignBottomRightInExactParent [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithExactExtent100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignBottom.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 300 @ 250.
	self assert: child extent equals: 100 @ 50.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAlignBottomRightInExactParentWithPadding [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithExactExtent100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignBottom.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent constraints padding: (BlInsets
			 top: 10
			 right: 20
			 bottom: 30
			 left: 40).
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 280 @ 220.
	self assert: child extent equals: 100 @ 50.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAlignCenterInExactParent [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithExactExtent100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignCenter.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 150 @ 125.
	self assert: child extent equals: 100 @ 50.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAlignCenterInExactParentWithPadding [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithExactExtent100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignCenter.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent constraints padding: (BlInsets
			 top: 10
			 right: 20
			 bottom: 30
			 left: 40).
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 160 @ 115.
	self assert: child extent equals: 100 @ 50.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAlignCenterLeftInExactParent [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithExactExtent100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignCenter.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 0 @ 125.
	self assert: child extent equals: 100 @ 50.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAlignCenterLeftInExactParentWithPadding [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithExactExtent100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignCenter.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent constraints padding: (BlInsets
			 top: 10
			 right: 20
			 bottom: 30
			 left: 40).
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 40 @ 115.
	self assert: child extent equals: 100 @ 50.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAlignCenterRightInExactParent [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithExactExtent100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignCenter.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 300 @ 125.
	self assert: child extent equals: 100 @ 50.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAlignCenterRightInExactParentWithPadding [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithExactExtent100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignCenter.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent constraints padding: (BlInsets
			 top: 10
			 right: 20
			 bottom: 30
			 left: 40).
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 280 @ 115.
	self assert: child extent equals: 100 @ 50.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAlignLeftInExactParent [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithExactExtent100per50.
	child constraints frame horizontal alignLeft.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 0 @ 0.
	self assert: child extent equals: 100 @ 50.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAlignRightInExactParentWithPadding [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithExactExtent100per50.
	child constraints frame horizontal alignRight.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent constraints padding: (BlInsets
			 top: 10
			 right: 20
			 bottom: 30
			 left: 40).
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 280 @ 10.
	self assert: child extent equals: 100 @ 50.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAlignTopCenterInExactParent [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithExactExtent100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignTop.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 150 @ 0.
	self assert: child extent equals: 100 @ 50.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAlignTopCenterInExactParentWithPadding [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithExactExtent100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignTop.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent constraints padding: (BlInsets
			 top: 10
			 right: 20
			 bottom: 30
			 left: 40).
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 160 @ 10.
	self assert: child extent equals: 100 @ 50.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAlignTopLeftInExactParent [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithExactExtent100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignTop.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 0 @ 0.
	self assert: child extent equals: 100 @ 50.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAlignTopLeftInExactParentWithPadding [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithExactExtent100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignTop.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent constraints padding: (BlInsets
			 top: 10
			 right: 20
			 bottom: 30
			 left: 40).
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 40 @ 10.
	self assert: child extent equals: 100 @ 50.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAlignTopRightInExactParent [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithExactExtent100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignTop.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 300 @ 0.
	self assert: child extent equals: 100 @ 50.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAlignTopRightInExactParentWithPadding [

	<sampleInstance>
	<demo>
	| child parent |
	child := self testChildElementWithExactExtent100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignTop.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent constraints padding: (BlInsets
			 top: 10
			 right: 20
			 bottom: 30
			 left: 40).
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 280 @ 10.
	self assert: child extent equals: 100 @ 50.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneExactChildAndFitContentParent [

	<sampleInstance>
	<demo>
	| child aParent |
	child := self testChildElementWithVisualProperties.
	child constraintsDo: [ :c |
		c vertical exact: 140.
		c horizontal exact: 140 ].
	aParent := BlElement new
		           layout: BlFrameLayout new;
		           border: (BlBorder builder
				            dashed;
				            paint: Color red;
				            width: 3;
				            build);
		           constraintsDo: [ :c |
			           c vertical fitContent.
			           c horizontal fitContent ].
	aParent addChild: child.
	aParent forceLayout.
	self assert: child position equals: 0 @ 0.
	self assert: child extent equals: 140 @ 140.
	self assert: aParent position equals: 0 @ 0.
	self assert: aParent extent equals: 140 @ 140.
	^ aParent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testElementWithOneMatchParentChildAndFitContentParent [

	<sampleInstance>
	<demo>
	| child aParent |
	child := self testChildElementWithVisualProperties.
	child constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent ].
	aParent := BlElement new
		           layout: BlFrameLayout new;
		           border: (BlBorder builder
				            dashed;
				            paint: Color red;
				            width: 3;
				            build);
		           constraintsDo: [ :c |
			           c vertical fitContent.
			           c horizontal fitContent ].
	aParent addChild: child.
	aParent forceLayout.
	self assert: child position equals: 0 @ 0.
	self assert: child extent equals: 0 @ 0.
	self assert: aParent position equals: 0 @ 0.
	self assert: aParent extent equals: 0 @ 0.
	^ aParent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testRelocateChildLargerWithPadding [

	<sampleInstance>
	<demo>
	| parent child |
	child := self testChildElementWithVisualProperties.
	child extent: 200 @ 100.
	"relocate more than padding"
	child position: 50 @ 75.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent padding: (BlInsets
			 top: 50
			 left: 25
			 bottom: 10
			 right: 15).
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 25 @ 50.
	self assert: child extent equals: 200 @ 100.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testRelocateChildSmallWithPadding [

	<sampleInstance>
	<demo>
	| parent child |
	child := self testChildElementWithVisualProperties.
	child extent: 200 @ 100.
	"relocate less than padding"
	child position: 10 @ 5.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent padding: (BlInsets
			 top: 50
			 left: 25
			 bottom: 10
			 right: 15).
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 25 @ 50.
	self assert: child extent equals: 200 @ 100.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testRelocateChildToZeroWithPadding [

	<sampleInstance>
	<demo>
	| parent child |
	child := self testChildElementWithVisualProperties.
	child extent: 200 @ 100.
	child position: 0 @ 0.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent padding: (BlInsets
			 top: 50
			 left: 25
			 bottom: 10
			 right: 15).
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 25 @ 50.
	self assert: child extent equals: 200 @ 100.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testRelocateChildWithoutAlignmentLargerWithPadding [

	<sampleInstance>
	<demo>
	| parent child |
	child := self testChildElementWithVisualProperties.
	child constraintsDo: [ :c |
		c frame horizontal alignNone.
		c frame vertical alignNone ].
	child extent: 200 @ 100.
	"relocate more than padding"
	child position: 50 @ 75.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent padding: (BlInsets
			 top: 50
			 left: 25
			 bottom: 10
			 right: 15).
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 50 @ 75.
	self assert: child extent equals: 200 @ 100.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testRelocateChildWithoutAlignmentSmallWithPadding [

	<sampleInstance>
	<demo>
	| parent child |
	child := self testChildElementWithVisualProperties.
	child constraintsDo: [ :c |
		c frame horizontal alignNone.
		c frame vertical alignNone ].
	child extent: 200 @ 100.
	"relocate less than padding"
	child position: 10 @ 5.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent padding: (BlInsets
			 top: 50
			 left: 25
			 bottom: 10
			 right: 15).
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 10 @ 5.
	self assert: child extent equals: 200 @ 100.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]

{ #category : #tests }
BlFrameLayoutSingleChildTest >> testRelocateChildWithoutAlignmentToZeroWithPadding [

	<sampleInstance>
	<demo>
	| parent child |
	child := self testChildElementWithVisualProperties.
	child constraintsDo: [ :c |
		c frame horizontal alignNone.
		c frame vertical alignNone ].
	child extent: 200 @ 100.
	child position: 0 @ 0.
	parent := self testParentWithFrameLayoutAndFixedExtent.
	parent padding: (BlInsets
			 top: 50
			 left: 25
			 bottom: 10
			 right: 15).
	parent addChild: child.
	parent forceLayout.
	self assert: child position equals: 0 @ 0.
	self assert: child extent equals: 200 @ 100.
	self assert: parent position equals: 0 @ 0.
	self assert: parent extent equals: 400 @ 300.
	^ parent
]
