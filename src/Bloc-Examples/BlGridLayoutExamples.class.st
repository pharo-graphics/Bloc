Class {
	#name : #BlGridLayoutExamples,
	#superclass : #Object,
	#traits : 'TBlLayoutExamplesSetup + TGtExampleAssertable',
	#classTraits : 'TBlLayoutExamplesSetup classTrait + TGtExampleAssertable classTrait',
	#category : #'Bloc-Examples-Layout'
}

{ #category : #'examples - layout' }
BlGridLayoutExamples >> exampleCellFitContent [
	<gtExample>
	| parent child subchild |

	parent := self parentWithGridHorizontalLayout.
	parent constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical fitContent ].
	parent background: Color white.

	child := self matchWidthFitHeight.
	child layout: BlGridLayout vertical.
	child background: Color paleBlue.

	subchild := self childExact: 200@100.
	subchild background: Color paleRed.

	child addChild: subchild.
	parent addChild: child.

	parent forceLayout.

	self assert: subchild extent equals: 200@100.
	self assert: subchild position equals: 0@0.

	self assert: child extent equals: 300@100.
	self assert: child position equals: 0@0.

	self assert: parent extent equals: 300@100.
	self assert: parent position equals: 0@0.

	^ parent
]

{ #category : #'examples - layout' }
BlGridLayoutExamples >> exampleCellSpacingHorizontal1 [
	<gtExample>
	| parent childA childB |

	childA := self childElementMatchingParent.
	childB := self childElementMatchingParent.

	parent := self parentWithGridHorizontalLayout.
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 200.
	parent layout cellSpacing: 20.
	parent layout horizontal.

	parent addChildren: { childA. childB }.
	parent forceLayout.

	self assert: childA extent equals: 170@160.
	self assert: childA position equals: 20@20.
	
	self assert: childB extent equals: 170@160.
	self assert: childB position equals: 210@20.
	
	self assert: parent extent equals: 400@200.
	self assert: parent position equals: 0@0.
	^ parent
]

{ #category : #'examples - layout' }
BlGridLayoutExamples >> exampleCellSpacingVerical1 [
	<gtExample>
	| parent childA childB |
	
	childA := self childElementMatchingParent.
	childB := self childElementMatchingParent.
	
	parent := self parentWithGridHorizontalLayout.
	parent constraints horizontal exact: 200.
	parent constraints vertical exact: 400.
	parent layout cellSpacing: 20.
	parent layout vertical.

	parent addChildren: { childA. childB }.
	parent forceLayout.

	self assert: childA extent equals: 160@170.
	self assert: childA position equals: 20@20.
	
	self assert: childB extent equals: 160@170.
	self assert: childB position equals: 20@210.
	
	self assert: parent extent equals: 200@400.
	self assert: parent position equals: 0@0.
	^ parent
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillEmpty [
	<gtExample>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.
	
	grid fill: array from: 0 to: 1 with: 1.

	self assert: array equals: #().
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillFirstInFourElements [
	<gtExample>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid fill: array from: 0 to: 1 with: 1.

	self assert: array equals: #(1 0 0 0).
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillForthInFourElements [
	<gtExample>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid fill: array from: 3 to: 4 with: 1.

	self assert: array equals: #(0 0 0 1).
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillOneElement [
	<gtExample>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 1 withAll: 0.
	
	grid fill: array from: 0 to: 1 with: 1.

	self assert: array equals: #(1).
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillOutOfBoundsEmpty1 [
	<gtExample>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.
	
	self
		should: [ grid fill: array from: -1 to: 0 with: 1 ]
		raise: SubscriptOutOfBounds 
		description: 'Should raise SubscriptOutOfBounds'.
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillOutOfBoundsEmpty2 [
	<gtExample>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.
	
	self
		should: [ grid fill: array from: -1 to: 1 with: 1 ]
		raise: SubscriptOutOfBounds 
		description: 'Should raise SubscriptOutOfBounds'.
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillOutOfBoundsEmpty3 [
	<gtExample>
	| grid array |
	
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.
	
	grid fill: array from: 0 to: 0 with: 1.
	self assert: array equals: #().
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillOutOfBoundsEmpty4 [
	<gtExample>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.
	grid fill: array from: 0 to: 2 with: 1.
	self assert: array equals: #().
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillOutOfBoundsInFourElements1 [
	<gtExample>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	self
		should: [ grid fill: array from: -1 to: 3 with: 1 ]
		raise: SubscriptOutOfBounds 
		description: 'Should raise SubscriptOutOfBounds'.
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillOutOfBoundsInFourElements2 [
	<gtExample>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	self
		should: [ grid fill: array from: -1 to: 6 with: 1 ]
		raise: SubscriptOutOfBounds 
		description: 'Should raise SubscriptOutOfBounds'.
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillOutOfBoundsInFourElements3 [
	<gtExample>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.
	grid fill: array from: 4 to: 6 with: 1.
	self assert: array equals: #(0 0 0 0).
	^ grid

]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillSecondInFourElements [
	<gtExample>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid fill: array from: 1 to: 2 with: 1.

	self assert: array equals: #(0 1 0 0).
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillThreeElements [
	<gtExample>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 3 withAll: 0.
	
	grid fill: array from: 0 to: 3 with: 1.

	self assert: array equals: #(1 1 1).
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillTwoElements [
	<gtExample>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 2 withAll: 0.
	
	grid fill: array from: 0 to: 2 with: 1.

	self assert: array equals: #(1 1).
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillTwoInFourElements1 [
	<gtExample>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid fill: array from: 0 to: 2 with: 1.

	self assert: array equals: #(1 1 0 0).
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillTwoInFourElements2 [
	<gtExample>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid fill: array from: 1 to: 3 with: 1.

	self assert: array equals: #(0 1 1 0).
	^ grid
]

{ #category : #'examples - unit - fill' }
BlGridLayoutExamples >> exampleGridLayoutArrayFillTwoInFourElements3 [
	<gtExample>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid fill: array from: 2 to: 4 with: 1.

	self assert: array equals: #(0 0 1 1).
	^ grid
]

{ #category : #'examples - layout' }
BlGridLayoutExamples >> exampleOneCellExactChildInExactParent [
	<gtExample>
	| parent child |
	
	child := self childExact: 200@300.
	
	parent := self parentWithGridHorizontalLayout.
	parent constraints horizontal exact: 300.
	parent constraints vertical exact: 400.

	parent addChild: child.
	parent forceLayout.

	self assert: child extent equals: 200@300.
	self assert: child position equals: 0@0.
	
	self assert: parent extent equals: 300@400.
	self assert: parent position equals: 0@0.
	^ parent
]

{ #category : #'examples - layout' }
BlGridLayoutExamples >> exampleOneCellExactChildInFitParent [
	<gtExample>
	| parent child |
	
	child := self childExact: 200@300.
	
	parent := self parentWithGridHorizontalLayout.
	parent constraints horizontal fitContent.
	parent constraints vertical fitContent.

	parent addChild: child.
	parent forceLayout.

	self assert: child extent equals: 200@300.
	self assert: child position equals: 0@0.
	
	self assert: parent extent equals: 200@300.
	self assert: parent position equals: 0@0.
	^ parent
]

{ #category : #'examples - layout' }
BlGridLayoutExamples >> exampleOneCellMatchChildInExactParent [
	<gtExample>
	| parent child |

	child := self childElementMatchingParent.
	
	parent := self parentWithGridHorizontalLayout.
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 300.

	parent addChild: child.
	parent forceLayout.

	self assert: child extent equals: 400@300.
	self assert: child position equals: 0@0.
	
	self assert: parent extent equals: 400@300.
	self assert: parent position equals: 0@0.
	^ parent
]

{ #category : #'examples - unit - spans' }
BlGridLayoutExamples >> exampleSpanDistributeOneColumn [
	<gtExample>
	| parent childA childB childC |

	childA := self childElementMatchingParent.
	childB := self childElementMatchingParent.
	childC := self childElementMatchingParent.
	
	parent := self parentWithGridHorizontalLayout.
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 400.
	parent layout columnCount: 1.
	
	parent addChildren: { childA. childB. childC }.
	parent forceLayout.
	
	self assert: (childA constraints grid horizontal spec span) equals: (BlGridLayoutInterval min: 0 max: 1).
	self assert: (childA constraints grid vertical spec span) equals: (BlGridLayoutInterval min: 0 max: 1).
	
	self assert: (childB constraints grid horizontal spec span) equals: (BlGridLayoutInterval min: 0 max: 1).
	self assert: (childB constraints grid vertical spec span) equals: (BlGridLayoutInterval min: 1 max: 2).
	
	self assert: (childC constraints grid horizontal spec span) equals: (BlGridLayoutInterval min: 0 max: 1).
	self assert: (childC constraints grid vertical spec span) equals: (BlGridLayoutInterval min: 2 max: 3).
	
	^ parent
]

{ #category : #'examples - unit - spans' }
BlGridLayoutExamples >> exampleSpanDistributeOneRow [
	<gtExample>
	| parent childA childB childC |

	childA := self childElementMatchingParent.
	childB := self childElementMatchingParent.
	childC := self childElementMatchingParent.
	
	parent := self parentWithGridHorizontalLayout.
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 400.
	parent layout rowCount: 1.
	
	parent addChildren: { childA. childB. childC }.
	parent forceLayout.
	
	self assert: (childA constraints grid horizontal spec span) equals: (BlGridLayoutInterval min: 0 max: 1).
	self assert: (childA constraints grid vertical spec span) equals: (BlGridLayoutInterval min: 0 max: 1).
	
	self assert: (childB constraints grid horizontal spec span) equals: (BlGridLayoutInterval min: 1 max: 2).
	self assert: (childB constraints grid vertical spec span) equals: (BlGridLayoutInterval min: 0 max: 1).
	
	self assert: (childC constraints grid horizontal spec span) equals: (BlGridLayoutInterval min: 2 max: 3).
	self assert: (childC constraints grid vertical spec span) equals: (BlGridLayoutInterval min: 0 max: 1).
	^ parent
]

{ #category : #'examples - setup' }
BlGridLayoutExamples >> matchWidthFitHeight [
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ]
]

{ #category : #'examples - setup' }
BlGridLayoutExamples >> parentWithGridHorizontalLayout [
	<gtExample>
	| element |
	element :=  BlElement new
		border: (BlBorder builder dashed; paint: Color red; width: 3; build);
		layout: BlGridLayout horizontal.
	
	self assert: element layout class equals: BlGridLayout.
	
	^ element
]
