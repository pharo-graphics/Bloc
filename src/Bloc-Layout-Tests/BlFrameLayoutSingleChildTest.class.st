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
	| child aParent |
	child := self testChildElementMatchingParent.
	aParent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithVisualProperties.
	child constraintsDo: [ :c |
		c horizontal exact: 140.
		c vertical exact: 140.
		c frame horizontal alignRight.
		c frame vertical alignBottom ].
	parent := self testParentWithFrameLayoutAndFixedSize.
	parent size: 300 @ 300.
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
	| parent child |
	child := self testChildElementWithVisualProperties.
	child constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent.
		c frame horizontal weight: 0.9.
		c frame vertical weight: 0.5 ].
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child aParent |
	child := self testChildElementMatchingParent.
	aParent := self testParentWithFrameLayoutAndFixedSize.
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
	| child aParent |
	self skip.
	self flag: #tofix.
	"This is the same code in Examples but I have no idea how to execute there to be sure that the test is passing as example."
	child := self testChildElementWithVisualProperties.
	aParent := self testParentWithFrameLayoutAndFixedSize.
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
BlFrameLayoutSingleChildTest >> testElementWithMinAndMaxHeightOneChildMatchExactParent [

	<sampleInstance>
	| child aParent |
	child := self testChildElementMatchingParent.
	aParent := self testParentWithFrameLayoutAndFixedSize.
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
	| child aParent |
	child := self testChildElementMatchingParent.
	aParent := self testParentWithFrameLayoutAndFixedSize.
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
	| child aParent |
	child := self testChildElementMatchingParent.
	aParent := self testParentWithFrameLayoutAndFixedSize.
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
	| child aParent |
	child := self testChildElementMatchingParent.
	aParent := self testParentWithFrameLayoutAndFixedSize.
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
	| child aParent |
	child := self testChildElementMatchingParent.
	aParent := self testParentWithFrameLayoutAndFixedSize.
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
	| aChild aParent |
	aChild := self testChildElementWithVisualProperties.
	aChild constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent ].
	aParent := self testParentWithFrameLayoutAndFixedSize.
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
	aParent := self testParentWithFrameLayoutAndFixedSize.
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
	| parent child |
	child := self testChildElementMatchingParentWith50per40Percent.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementMatchingParentWith25per50Percent.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementMatchingParentWith25per50Percent.
	child margin: (BlInsets
			 top: 40
			 right: 30
			 bottom: 20
			 left: 10).
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| parent child subChild |
	subChild := self testChildElementWithVisualProperties.
	subChild constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical exact: 300 ].
	child := self testChildElementMatchingWidthFitHeight.
	child layout: BlLinearLayout horizontal.
	child addChild: subChild.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| parent child subChild |
	subChild := self testChildElementWithVisualProperties.
	subChild constraintsDo: [ :c |
		c horizontal exact: 500.
		c vertical exact: 500 ].

	"the child's width should be 400, while height is limited to parent's height (300)"
	child := self testChildElementMatchingWidthFitLimitedHeight.
	child layout: BlLinearLayout horizontal.
	child addChild: subChild.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| parent child |
	child := self testChildElementWithVisualProperties.
	child constraintsDo: [ :c |
		c horizontal exact: 140.
		c vertical exact: 140.
		c frame horizontal weight: 0.9.
		c frame vertical weight: 0.5 ].
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithExactSize100per50.
	child constraintsDo: [ :c |
		c frame horizontal weight: 0.9.
		c frame vertical weight: 0.5.
		c frame horizontal alignCenter.
		c frame vertical alignBottom ].
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithExactSize100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignBottom.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithExactSize100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignBottom.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithExactSize100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignBottom.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithExactSize100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignBottom.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithExactSize100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignBottom.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithExactSize100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignBottom.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithExactSize100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignCenter.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithExactSize100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignCenter.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithExactSize100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignCenter.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithExactSize100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignCenter.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithExactSize100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignCenter.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithExactSize100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignCenter.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithExactSize100per50.
	child constraints frame horizontal alignLeft.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithExactSize100per50.
	child constraints frame horizontal alignRight.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithExactSize100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignTop.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithExactSize100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignTop.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithExactSize100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignTop.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithExactSize100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignTop.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithExactSize100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignTop.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| child parent |
	child := self testChildElementWithExactSize100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignTop.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| parent child |
	child := self testChildElementWithVisualProperties.
	child size: 200 @ 100.
	"relocate more than padding"
	child position: 50 @ 75.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| parent child |
	child := self testChildElementWithVisualProperties.
	child size: 200 @ 100.
	"relocate less than padding"
	child position: 10 @ 5.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| parent child |
	child := self testChildElementWithVisualProperties.
	child size: 200 @ 100.
	child position: 0 @ 0.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| parent child |
	child := self testChildElementWithVisualProperties.
	child constraintsDo: [ :c |
		c frame horizontal alignNone.
		c frame vertical alignNone ].
	child size: 200 @ 100.
	"relocate more than padding"
	child position: 50 @ 75.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| parent child |
	child := self testChildElementWithVisualProperties.
	child constraintsDo: [ :c |
		c frame horizontal alignNone.
		c frame vertical alignNone ].
	child size: 200 @ 100.
	"relocate less than padding"
	child position: 10 @ 5.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
	| parent child |
	child := self testChildElementWithVisualProperties.
	child constraintsDo: [ :c |
		c frame horizontal alignNone.
		c frame vertical alignNone ].
	child size: 200 @ 100.
	child position: 0 @ 0.
	parent := self testParentWithFrameLayoutAndFixedSize.
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
