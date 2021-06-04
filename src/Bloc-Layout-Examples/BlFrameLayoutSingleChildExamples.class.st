"
I contain examples of positioning a single element within a parent element that uses a {{gtClass:BlFrameLayout}}.

"
Class {
	#name : #BlFrameLayoutSingleChildExamples,
	#superclass : #BlFrameLayoutChildrenExamples,
	#category : #'Bloc-Layout-Examples-Frame'
}

{ #category : #'examples - setup' }
BlFrameLayoutSingleChildExamples >> childElementMatchingParentWith25per50Percent [
	<gtExample>
	| element |
	element := self childElementWithVisualProperties.
	element constraintsDo: [ :c | 
		c vertical matchParent.
		c horizontal matchParent.
		c frame horizontal weight: 0.25.
		c frame vertical weight: 0.5 ].
		
	self assert: element position equals: 0@0.
	self assert: element extent equals: 0@0.
	self assert: element constraints horizontal resizer isMatchParent.
	self assert: element constraints vertical resizer isMatchParent.
	self assert: element constraints frame horizontal weight equals: 0.25.
	self assert: element constraints frame vertical weight equals: 0.5.
	
	^ element
]

{ #category : #'examples - setup' }
BlFrameLayoutSingleChildExamples >> childElementMatchingParentWith50per40Percent [
	<gtExample>
	| element |
	element := self childElementWithVisualProperties.
	element constraintsDo: [ :c | 
		c vertical matchParent.
		c horizontal matchParent.
		c frame horizontal weight: 0.5.
		c frame vertical weight: 0.4 ].
	
	self assert: element position equals: 0@0.
	self assert: element extent equals: 0@0.
	self assert: element constraints horizontal resizer isMatchParent.
	self assert: element constraints vertical resizer isMatchParent.
	self assert: element constraints frame horizontal weight equals: 0.5.
	self assert: element constraints frame vertical weight equals: 0.4.
		
	^ element
]

{ #category : #'examples - setup' }
BlFrameLayoutSingleChildExamples >> childElementMatchingWidthFitHeight [
	<gtExample>
	| element |
	element := self childElementWithVisualProperties.
	element constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
		
	self assert: element position equals: 0@0.
	self assert: element extent equals: 0@0.
	self assert: element constraints horizontal resizer isMatchParent.
	self assert: element constraints vertical resizer isFitContent.
	self assert: element constraints frame horizontal weight equals: 1.0.
	self assert: element constraints frame vertical weight equals: 1.0.
	
	^ element
]

{ #category : #'examples - setup' }
BlFrameLayoutSingleChildExamples >> childElementMatchingWidthFitLimitedHeight [
	<gtExample>
	| element |
	element := self childElementWithVisualProperties.
	element constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContentLimited ].
		
	self assert: element position equals: 0@0.
	self assert: element extent equals: 0@0.
	self assert: element constraints horizontal resizer isMatchParent.
	self assert: element constraints vertical resizer isFitContent.
	self assert: element constraints frame horizontal weight equals: 1.0.
	self assert: element constraints frame vertical weight equals: 1.0.
	
	^ element
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementDocumentationWithOneExactChildAlignBottomRightInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithVisualProperties.
	child constraintsDo: [ :c |
		c horizontal exact: 140.
		c vertical exact: 140.
		c frame horizontal alignRight.
		c frame vertical alignBottom ].

	parent := self parentWithFrameLayoutAndFixedSize.	
	parent size: 300@300.
	parent addChild: child.
	
	parent forceLayout.
	self assert: child position equals: 160@160.
	self assert: child extent equals: 140@140.
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 300@300.
	
	^ parent
]

{ #category : #'examples - weight' }
BlFrameLayoutSingleChildExamples >> elementForDocumentationWithOneChildMatchExactParentWithWeight [
	<gtExample>
	| parent child |
	
	child := self childElementWithVisualProperties.
	child constraintsDo: [ :c | 
		c vertical matchParent.
		c horizontal matchParent.
		c frame horizontal weight: 0.9.
		c frame vertical weight: 0.5 ].
	parent := self parentWithFrameLayoutAndFixedSize.
	parent addChild: child.
	parent forceLayout.
	
	self assert: child position equals: 0@0.
	self assert: child extent equals: 360@150.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - max extent' }
BlFrameLayoutSingleChildExamples >> elementWithMaxHeightOneChildMatchExactParent [
	<gtExample>
	| child aParent |
	child := self childElementMatchingParent.
	aParent := self parentWithFrameLayoutAndFixedSize.
	aParent constraintsDo: [ :c | c maxHeight: 200 ].
	
	aParent addChild: child.
	aParent forceLayout.

	self assert: child position equals: 0@0.
	self assert: child extent equals: 400@200.

	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 400@200.

	^ aParent
]

{ #category : #'examples - max extent' }
BlFrameLayoutSingleChildExamples >> elementWithMaxWidthOneChildMatchExactParent [
	<gtExample>
	| child aParent |
	child := self childElementMatchingParent.
	aParent := self parentWithFrameLayoutAndFixedSize.
	aParent constraintsDo: [ :c | c maxWidth: 200 ].
	
	aParent addChild: child.
	aParent forceLayout.

	self assert: child position equals: 0@0.
	self assert: child extent equals: 200@300.

	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 200@300.

	^ aParent
]

{ #category : #'examples - max extent' }
BlFrameLayoutSingleChildExamples >> elementWithMinAndMaxHeightOneChildMatchExactParent [
	<gtExample>
	| child aParent |
	child := self childElementMatchingParent.
	aParent := self parentWithFrameLayoutAndFixedSize.
	aParent constraintsDo: [ :c |
		c maxHeight: 200.
		c minHeight: 500 ]. "minHeight has a precedence over maxHeight"

	aParent addChild: child.
	aParent forceLayout.

	self assert: child position equals: 0@0.
	self assert: child extent equals: 400@500.

	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 400@500.

	^ aParent
]

{ #category : #'examples - max extent' }
BlFrameLayoutSingleChildExamples >> elementWithMinAndMaxWidthOneChildMatchExactParent [
	<gtExample>
	| child aParent |
	child := self childElementMatchingParent.
	aParent := self parentWithFrameLayoutAndFixedSize.
	aParent constraintsDo: [ :c |
		c maxWidth: 200.
		c minWidth: 500 ]. "minWidth has a precedence over maxWidth"
	
	aParent addChild: child.
	aParent forceLayout.

	self assert: child position equals: 0@0.
	self assert: child extent equals: 500@300.

	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 500@300.

	^ aParent
]

{ #category : #'examples - max extent' }
BlFrameLayoutSingleChildExamples >> elementWithMinHeightOneChildMatchExactParent [
	<gtExample>
	| child aParent |
	child := self childElementMatchingParent.
	aParent := self parentWithFrameLayoutAndFixedSize.
	aParent constraintsDo: [ :c | c minHeight: 500 ].
	
	aParent addChild: child.
	aParent forceLayout.

	self assert: child position equals: 0@0.
	self assert: child extent equals: 400@500.

	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 400@500.

	^ aParent
]

{ #category : #'examples - max extent' }
BlFrameLayoutSingleChildExamples >> elementWithMinWidthOneChildMatchExactParent [
	<gtExample>
	| child aParent |
	child := self childElementMatchingParent.
	aParent := self parentWithFrameLayoutAndFixedSize.
	aParent constraintsDo: [ :c | c minWidth: 500 ].
	
	aParent addChild: child.
	aParent forceLayout.

	self assert: child position equals: 0@0.
	self assert: child extent equals: 500@300.

	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 500@300.

	^ aParent
]

{ #category : #'examples - matching parent' }
BlFrameLayoutSingleChildExamples >> elementWithOneChildMatchExactParent [
	<gtExample>
	| child aParent |
	child := self childElementMatchingParent.
	aParent := self parentWithFrameLayoutAndFixedSize.
	
	aParent addChild: child.
	aParent forceLayout.
	
	self assert: child position equals: 0@0.
	self assert: child extent equals: 400@300.
	
	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 400@300.
	
	^ aParent
]

{ #category : #'examples - matching parent' }
BlFrameLayoutSingleChildExamples >> elementWithOneChildMatchExactParentWithPadding [
	<gtExample>
	| aChild aParent |
	
	aChild := self childElementWithVisualProperties.
	aChild constraintsDo: [ :c | 
		c vertical matchParent.
		c horizontal matchParent ].
	aParent := self parentWithFrameLayoutAndFixedSize.

	aParent constraints 
		padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	aParent addChild: aChild.
	aParent forceLayout.

	self assert: aChild position equals: 40@10.
	self assert: aChild extent equals: 340@260.
	
	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 400@300.
	
	^ aParent
]

{ #category : #'examples - matching parent' }
BlFrameLayoutSingleChildExamples >> elementWithOneChildMatchExactParentWithPaddingAndMargin [
	<gtExample>
	| aChild aParent |
	
	aChild := self childElementWithVisualProperties.
	aChild constraintsDo: [ :c | 
		c vertical matchParent.
		c horizontal matchParent ].
	aChild margin: (BlInsets top: 40 right: 30 bottom: 20 left: 10).
	
	aParent := self parentWithFrameLayoutAndFixedSize.
	aParent padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	aParent addChild: aChild.
	
	aParent forceLayout.

	self assert: aChild position equals: 50@50.
	self assert: aChild extent equals: 300@200.
	
	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 400@300.
	
	^ aParent
]

{ #category : #'examples - weight' }
BlFrameLayoutSingleChildExamples >> elementWithOneChildMatchExactParentWithWeight [
	<gtExample>
	| parent child |
	
	child := self childElementMatchingParentWith50per40Percent.
	parent := self parentWithFrameLayoutAndFixedSize.
	parent addChild: child.
	parent forceLayout.
	
	self assert: child position equals: 0@0.
	self assert: child extent equals: 200@120.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - weight' }
BlFrameLayoutSingleChildExamples >> elementWithOneChildMatchExactParentWithWeightAndPadding [
	<gtExample>
	| child parent |
	
	child := self childElementMatchingParentWith25per50Percent.
	parent := self parentWithFrameLayoutAndFixedSize.
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 40@10.
	self assert: child extent equals: 85@130.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - weight' }
BlFrameLayoutSingleChildExamples >> elementWithOneChildMatchExactParentWithWeightAndPaddingAndMargin [
	<gtExample>
	| child parent |
	
	child := self childElementMatchingParentWith25per50Percent.
	child margin: (BlInsets top: 40 right: 30 bottom: 20 left: 10).
	
	parent := self parentWithFrameLayoutAndFixedSize.
	parent padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	parent addChild: child.
	
	parent forceLayout.

	self assert: child position equals: 50@50.
	self assert: child extent equals: 75@100.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - fit content' }
BlFrameLayoutSingleChildExamples >> elementWithOneChildMatchWidthFitHeightParentExactWidthFitHeight [
	<gtExample>
	| parent child subChild |

	subChild := self childElementWithVisualProperties.
	subChild constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical exact: 300 ].

	child := self childElementMatchingWidthFitHeight.
	child layout: BlLinearLayout horizontal.
	child addChild: subChild.

	parent := self parentWithFrameLayoutAndFixedSize.
	parent constraintsDo: [ :c | c vertical fitContent ].
	parent addChild: child.
	parent forceLayout.

	self assert: subChild position equals: 0@0.
	self assert: subChild extent equals: 300@300.

	self assert: child position equals: 0@0.
	self assert: child extent equals: 400@300.

	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.

	^ parent
]

{ #category : #'examples - fit content' }
BlFrameLayoutSingleChildExamples >> elementWithOneChildMatchWidthFitLimitedHeightParentExactWidthFitHeight [
	<gtExample>
	| parent child subChild |

	subChild := self childElementWithVisualProperties.
	subChild constraintsDo: [ :c |
		c horizontal exact: 500.
		c vertical exact: 500 ].

	"the child's width should be 400, while height is limited to parent's height (300)"
	child := self childElementMatchingWidthFitLimitedHeight.
	child layout: BlLinearLayout horizontal.
	child addChild: subChild.

	parent := self parentWithFrameLayoutAndFixedSize.
	parent addChild: child.
	parent forceLayout.

	self assert: subChild position equals: 0@0.
	self assert: subChild extent equals: 500@500.

	self assert: child position equals: 0@0.
	self assert: child extent equals: 400@300.

	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.

	^ parent
]

{ #category : #'examples - weight' }
BlFrameLayoutSingleChildExamples >> elementWithOneChildWithExactSizeParentWithWeight [
	<gtExample>
	| parent child |
	
	child := self childElementWithVisualProperties.
	child constraintsDo: [ :c |
		c horizontal exact: 140.
		c vertical exact: 140.
		c frame horizontal weight: 0.9.
		c frame vertical weight: 0.5 ].
	
	parent := self parentWithFrameLayoutAndFixedSize.
	parent addChild: child.
	parent forceLayout.
	
	self assert: child position equals: 0@0.
	self assert: child extent equals: 140@140.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignBottomCenterAndWithWeightInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraintsDo: [ :c |
		c frame horizontal weight: 0.9.
		c frame vertical weight: 0.5.
		c frame horizontal alignCenter.
		c frame vertical alignBottom.  ].

	parent := self parentWithFrameLayoutAndFixedSize.
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 150@250.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignBottomCenterInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignBottom.

	parent := self parentWithFrameLayoutAndFixedSize.
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 150@250.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignBottomCenterInExactParentWithPadding [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignBottom.
	
	parent := self parentWithFrameLayoutAndFixedSize.
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 160@220.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent 
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignBottomLeftInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignBottom.
.
	parent := self parentWithFrameLayoutAndFixedSize.	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 0@250.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignBottomLeftInExactParentWithPadding [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignBottom.
	
	parent :=  self parentWithFrameLayoutAndFixedSize.	
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 40@220.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignBottomRightInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignBottom.

	parent := self parentWithFrameLayoutAndFixedSize.	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 300@250.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignBottomRightInExactParentWithPadding [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignBottom.
	
	parent := self parentWithFrameLayoutAndFixedSize.	
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 280@220.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignCenterInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignCenter.

	parent := self parentWithFrameLayoutAndFixedSize.	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 150@125.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignCenterInExactParentWithPadding [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignCenter.
	
	parent := self parentWithFrameLayoutAndFixedSize.	
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 160@115.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignCenterLeftInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignCenter.

	parent := self parentWithFrameLayoutAndFixedSize.	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 0@125.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignCenterLeftInExactParentWithPadding [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignCenter.
	
	parent := self parentWithFrameLayoutAndFixedSize.	
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 40@115.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignCenterRightInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignCenter.

	parent := self parentWithFrameLayoutAndFixedSize.	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 300@125.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignCenterRightInExactParentWithPadding [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignCenter.
	
	parent := self parentWithFrameLayoutAndFixedSize.	
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 280@115.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignLeftInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignLeft.

	parent := self parentWithFrameLayoutAndFixedSize.		
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 0@0.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignRightInExactParentWithPadding [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignRight.
	
	parent := self parentWithFrameLayoutAndFixedSize.	
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 280@10.
	self assert: child extent equals: 100@50.

	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignTopCenterInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignTop.

	parent := self parentWithFrameLayoutAndFixedSize.	
	parent addChild: child.
	parent forceLayout.

	self assert: child position equals: 150@0.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignTopCenterInExactParentWithPadding [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignTop.
	
	parent := self parentWithFrameLayoutAndFixedSize.	
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 160@10.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignTopLeftInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignTop.

	parent := self parentWithFrameLayoutAndFixedSize.	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 0@0.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignTopLeftInExactParentWithPadding [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignTop.
	
	parent := self parentWithFrameLayoutAndFixedSize.
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 40@10.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent 
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignTopRightInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignTop.

	parent := self parentWithFrameLayoutAndFixedSize.
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 300@0.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignTopRightInExactParentWithPadding [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignTop.
	
	parent := self parentWithFrameLayoutAndFixedSize.
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 280@10.
	self assert: child extent equals: 100@50.

	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - fit content' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAndFitContentParent [
	<gtExample>
	| child aParent |
	child := self childElementWithVisualProperties.
	child constraintsDo: [ :c | 
		c vertical exact: 140.
		c horizontal exact: 140 ].
	aParent := BlElement new
		layout: BlFrameLayout new;
		border: (BlBorder builder dashed; paint: Color red; width: 3; build);
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ].
	
	aParent addChild: child.
	aParent forceLayout.
	
	self assert: child position equals: 0@0.
	self assert: child extent equals: 140@140.
	
	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 140@140.
	
	^ aParent
]

{ #category : #'examples - fit content' }
BlFrameLayoutSingleChildExamples >> elementWithOneMatchParentChildAndFitContentParent [
	<gtExample>
	| child aParent |
	child := self childElementWithVisualProperties.
	child constraintsDo: [ :c | 
		c vertical matchParent.
		c horizontal matchParent ].
	aParent := BlElement new
		layout: BlFrameLayout new;
		border: (BlBorder builder dashed; paint: Color red; width: 3; build);
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ].
	
	aParent addChild: child.
	aParent forceLayout.
	
	self assert: child position equals: 0@0.
	self assert: child extent equals: 0@0.
	
	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 0@0.
	
	^ aParent
]

{ #category : #'examples - padding' }
BlFrameLayoutSingleChildExamples >> relocateChildLargerWithPadding [
	<gtExample>
	| parent child |

	child := self childElementWithVisualProperties.
	child size: 200@100.
	"relocate more than padding"
	child relocate: 50@75.

	parent := self parentWithFrameLayoutAndFixedSize.
	parent padding: (BlInsets top: 50 left: 25 bottom: 10 right: 15).
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 25@50.
	self assert: child extent equals: 200@100.

	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.

	^ parent
]

{ #category : #'examples - padding' }
BlFrameLayoutSingleChildExamples >> relocateChildSmallWithPadding [
	<gtExample>
	| parent child |

	child := self childElementWithVisualProperties.
	child size: 200@100.
	"relocate less than padding"
	child relocate: 10@5.

	parent := self parentWithFrameLayoutAndFixedSize.
	parent padding: (BlInsets top: 50 left: 25 bottom: 10 right: 15).
	parent addChild: child.
	
	parent forceLayout.

	self assert: child position equals: 25@50.
	self assert: child extent equals: 200@100.

	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.

	^ parent
]

{ #category : #'examples - padding' }
BlFrameLayoutSingleChildExamples >> relocateChildToZeroWithPadding [
	<gtExample>
	| parent child |

	child := self childElementWithVisualProperties.
	child size: 200@100.
	child relocate: 0@0.

	parent := self parentWithFrameLayoutAndFixedSize.
	parent padding: (BlInsets top: 50 left: 25 bottom: 10 right: 15).
	parent addChild: child.
	parent forceLayout.

	self assert: child position equals: 25@50.
	self assert: child extent equals: 200@100.

	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.

	^ parent
]

{ #category : #'examples - padding' }
BlFrameLayoutSingleChildExamples >> relocateChildWithoutAlignmentLargerWithPadding [
	<gtExample>
	| parent child |

	child := self childElementWithVisualProperties.
	child constraintsDo: [ :c |
		c frame horizontal alignNone.
		c frame vertical alignNone ].
	child size: 200@100.
	"relocate more than padding"
	child relocate: 50@75.

	parent := self parentWithFrameLayoutAndFixedSize.
	parent padding: (BlInsets top: 50 left: 25 bottom: 10 right: 15).
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 50@75.
	self assert: child extent equals: 200@100.

	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.

	^ parent
]

{ #category : #'examples - padding' }
BlFrameLayoutSingleChildExamples >> relocateChildWithoutAlignmentSmallWithPadding [
	<gtExample>
	| parent child |

	child := self childElementWithVisualProperties.
	child constraintsDo: [ :c |
		c frame horizontal alignNone.
		c frame vertical alignNone ].
	child size: 200@100.
	"relocate less than padding"
	child relocate: 10@5.

	parent := self parentWithFrameLayoutAndFixedSize.
	parent padding: (BlInsets top: 50 left: 25 bottom: 10 right: 15).
	parent addChild: child.
	
	parent forceLayout.

	self assert: child position equals: 10@5.
	self assert: child extent equals: 200@100.

	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.

	^ parent
]

{ #category : #'examples - padding' }
BlFrameLayoutSingleChildExamples >> relocateChildWithoutAlignmentToZeroWithPadding [
	<gtExample>
	| parent child |

	child := self childElementWithVisualProperties.
	child constraintsDo: [ :c |
		c frame horizontal alignNone.
		c frame vertical alignNone ].
	child size: 200@100.
	child relocate: 0@0.

	parent := self parentWithFrameLayoutAndFixedSize.
	parent padding: (BlInsets top: 50 left: 25 bottom: 10 right: 15).
	parent addChild: child.
	parent forceLayout.

	self assert: child position equals: 0@0.
	self assert: child extent equals: 200@100.

	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.

	^ parent
]
