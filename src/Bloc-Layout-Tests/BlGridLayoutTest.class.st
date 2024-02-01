"
I have been automatically converted and probably manually tweaked from BlGridLayoutExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlGridLayoutTest,
	#superclass : #BlRootLayoutTest,
	#category : #'Bloc-Layout-Tests'
}

{ #category : #fixture }
BlGridLayoutTest >> childExact: aPoint [

	^ self testChildElementWithVisualProperties
		  constraintsDo: [ :c |
			  c horizontal exact: aPoint x.
			  c vertical exact: aPoint y ];
		  yourself
]

{ #category : #fixture }
BlGridLayoutTest >> matchWidthFitHeight [

	<sampleInstance>
	<demo>
	^ BlElement new constraintsDo: [ :c |
		  c horizontal matchParent.
		  c vertical fitContent ]
]

{ #category : #tests }
BlGridLayoutTest >> testExampleCellFitContent [

	<sampleInstance>
	<demo>
	| parent child subchild |
	parent := self testParentWithGridHorizontalLayout.
	parent constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical fitContent ].
	parent background: Color white.

	child := self matchWidthFitHeight.
	child layout: BlGridLayout vertical.
	child background: Color paleBlue.

	subchild := self childExact: 200 @ 100.
	subchild background: Color paleRed.

	child addChild: subchild.
	parent addChild: child.

	parent forceLayout.

	self assert: subchild extent equals: 200 @ 100.
	self assert: subchild position equals: 0 @ 0.

	self assert: child extent equals: 300 @ 100.
	self assert: child position equals: 0 @ 0.

	self assert: parent extent equals: 300 @ 100.
	self assert: parent position equals: 0 @ 0.

	^ parent
]

{ #category : #tests }
BlGridLayoutTest >> testExampleCellSpacingHorizontal1 [

	<sampleInstance>
	<demo>
	| parent childA childB |
	childA := self testChildElementMatchingParent.
	childB := self testChildElementMatchingParent.

	parent := self testParentWithGridHorizontalLayout.
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 200.
	parent layout cellSpacing: 20.
	parent layout horizontal.

	parent addChildren: {
			childA.
			childB }.
	parent forceLayout.

	self assert: childA extent equals: 170 @ 160.
	self assert: childA position equals: 20 @ 20.

	self assert: childB extent equals: 170 @ 160.
	self assert: childB position equals: 210 @ 20.

	self assert: parent extent equals: 400 @ 200.
	self assert: parent position equals: 0 @ 0.
	^ parent
]

{ #category : #tests }
BlGridLayoutTest >> testExampleCellSpacingVertical1 [

	<sampleInstance>
	<demo>
	| parent childA childB |
	childA := self testChildElementMatchingParent.
	childB := self testChildElementMatchingParent.

	parent := self testParentWithGridHorizontalLayout.
	parent constraints horizontal exact: 200.
	parent constraints vertical exact: 400.
	parent layout cellSpacing: 20.
	parent layout vertical.

	parent addChildren: {
			childA.
			childB }.
	parent forceLayout.

	self assert: childA extent equals: 160 @ 170.
	self assert: childA position equals: 20 @ 20.

	self assert: childB extent equals: 160 @ 170.
	self assert: childB position equals: 20 @ 210.

	self assert: parent extent equals: 200 @ 400.
	self assert: parent position equals: 0 @ 0.
	^ parent
]

{ #category : #tests }
BlGridLayoutTest >> testExampleGridLayoutArrayFillEmpty [

	<sampleInstance>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.

	grid
		fill: array
		from: 0
		to: 1
		with: 1.

	self assert: array equals: #(  ).
	^ grid
]

{ #category : #tests }
BlGridLayoutTest >> testExampleGridLayoutArrayFillFirstInFourElements [

	<sampleInstance>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid
		fill: array
		from: 0
		to: 1
		with: 1.

	self assert: array equals: #( 1 0 0 0 ).
	^ grid
]

{ #category : #tests }
BlGridLayoutTest >> testExampleGridLayoutArrayFillForthInFourElements [

	<sampleInstance>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid
		fill: array
		from: 3
		to: 4
		with: 1.

	self assert: array equals: #( 0 0 0 1 ).
	^ grid
]

{ #category : #tests }
BlGridLayoutTest >> testExampleGridLayoutArrayFillOneElement [

	<sampleInstance>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 1 withAll: 0.

	grid
		fill: array
		from: 0
		to: 1
		with: 1.

	self assert: array equals: #( 1 ).
	^ grid
]

{ #category : #tests }
BlGridLayoutTest >> testExampleGridLayoutArrayFillOutOfBoundsEmpty1 [

	<sampleInstance>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.

	self
		should: [
			grid
				fill: array
				from: -1
				to: 0
				with: 1 ]
		raise: SubscriptOutOfBounds
		description: 'Should raise SubscriptOutOfBounds'.
	^ grid
]

{ #category : #tests }
BlGridLayoutTest >> testExampleGridLayoutArrayFillOutOfBoundsEmpty2 [

	<sampleInstance>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.

	self
		should: [
			grid
				fill: array
				from: -1
				to: 1
				with: 1 ]
		raise: SubscriptOutOfBounds
		description: 'Should raise SubscriptOutOfBounds'.
	^ grid
]

{ #category : #tests }
BlGridLayoutTest >> testExampleGridLayoutArrayFillOutOfBoundsEmpty3 [

	<sampleInstance>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.

	grid
		fill: array
		from: 0
		to: 0
		with: 1.
	self assert: array equals: #(  ).
	^ grid
]

{ #category : #tests }
BlGridLayoutTest >> testExampleGridLayoutArrayFillOutOfBoundsEmpty4 [

	<sampleInstance>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.
	grid
		fill: array
		from: 0
		to: 2
		with: 1.
	self assert: array equals: #(  ).
	^ grid
]

{ #category : #tests }
BlGridLayoutTest >> testExampleGridLayoutArrayFillOutOfBoundsInFourElements1 [

	<sampleInstance>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	self
		should: [
			grid
				fill: array
				from: -1
				to: 3
				with: 1 ]
		raise: SubscriptOutOfBounds
		description: 'Should raise SubscriptOutOfBounds'.
	^ grid
]

{ #category : #tests }
BlGridLayoutTest >> testExampleGridLayoutArrayFillOutOfBoundsInFourElements2 [

	<sampleInstance>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	self
		should: [
			grid
				fill: array
				from: -1
				to: 6
				with: 1 ]
		raise: SubscriptOutOfBounds
		description: 'Should raise SubscriptOutOfBounds'.
	^ grid
]

{ #category : #tests }
BlGridLayoutTest >> testExampleGridLayoutArrayFillOutOfBoundsInFourElements3 [

	<sampleInstance>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.
	grid
		fill: array
		from: 4
		to: 6
		with: 1.
	self assert: array equals: #( 0 0 0 0 ).
	^ grid
]

{ #category : #tests }
BlGridLayoutTest >> testExampleGridLayoutArrayFillSecondInFourElements [

	<sampleInstance>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid
		fill: array
		from: 1
		to: 2
		with: 1.

	self assert: array equals: #( 0 1 0 0 ).
	^ grid
]

{ #category : #tests }
BlGridLayoutTest >> testExampleGridLayoutArrayFillThreeElements [

	<sampleInstance>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 3 withAll: 0.

	grid
		fill: array
		from: 0
		to: 3
		with: 1.

	self assert: array equals: #( 1 1 1 ).
	^ grid
]

{ #category : #tests }
BlGridLayoutTest >> testExampleGridLayoutArrayFillTwoElements [

	<sampleInstance>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 2 withAll: 0.

	grid
		fill: array
		from: 0
		to: 2
		with: 1.

	self assert: array equals: #( 1 1 ).
	^ grid
]

{ #category : #tests }
BlGridLayoutTest >> testExampleGridLayoutArrayFillTwoInFourElements1 [

	<sampleInstance>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid
		fill: array
		from: 0
		to: 2
		with: 1.

	self assert: array equals: #( 1 1 0 0 ).
	^ grid
]

{ #category : #tests }
BlGridLayoutTest >> testExampleGridLayoutArrayFillTwoInFourElements2 [

	<sampleInstance>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid
		fill: array
		from: 1
		to: 3
		with: 1.

	self assert: array equals: #( 0 1 1 0 ).
	^ grid
]

{ #category : #tests }
BlGridLayoutTest >> testExampleGridLayoutArrayFillTwoInFourElements3 [

	<sampleInstance>
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid
		fill: array
		from: 2
		to: 4
		with: 1.

	self assert: array equals: #( 0 0 1 1 ).
	^ grid
]

{ #category : #tests }
BlGridLayoutTest >> testExampleOneCellExactChildInExactParent [

	<sampleInstance>
	<demo>
	| parent child |
	child := self childExact: 200 @ 300.

	parent := self testParentWithGridHorizontalLayout.
	parent constraints horizontal exact: 300.
	parent constraints vertical exact: 400.

	parent addChild: child.
	parent forceLayout.

	self assert: child extent equals: 200 @ 300.
	self assert: child position equals: 0 @ 0.

	self assert: parent extent equals: 300 @ 400.
	self assert: parent position equals: 0 @ 0.
	^ parent
]

{ #category : #tests }
BlGridLayoutTest >> testExampleOneCellExactChildInFitParent [

	<sampleInstance>
	<demo>
	| parent child |
	child := self childExact: 200 @ 300.

	parent := self testParentWithGridHorizontalLayout.
	parent constraints horizontal fitContent.
	parent constraints vertical fitContent.

	parent addChild: child.
	parent forceLayout.

	self assert: child extent equals: 200 @ 300.
	self assert: child position equals: 0 @ 0.

	self assert: parent extent equals: 200 @ 300.
	self assert: parent position equals: 0 @ 0.
	^ parent
]

{ #category : #tests }
BlGridLayoutTest >> testExampleOneCellMatchChildInExactParent [

	<sampleInstance>
	<demo>
	| parent child |
	child := self testChildElementMatchingParent.

	parent := self testParentWithGridHorizontalLayout.
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 300.

	parent addChild: child.
	parent forceLayout.

	self assert: child extent equals: 400 @ 300.
	self assert: child position equals: 0 @ 0.

	self assert: parent extent equals: 400 @ 300.
	self assert: parent position equals: 0 @ 0.
	^ parent
]

{ #category : #tests }
BlGridLayoutTest >> testExampleSpanDistributeOneColumn [

	<sampleInstance>
	<demo>
	| parent childA childB childC |
	childA := self testChildElementMatchingParent.
	childB := self testChildElementMatchingParent.
	childC := self testChildElementMatchingParent.

	parent := self testParentWithGridHorizontalLayout.
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 400.
	parent layout columnCount: 1.

	parent addChildren: {
			childA.
			childB.
			childC }.
	parent forceLayout.

	self
		assert: childA constraints grid horizontal spec span
		equals: (BlGridLayoutInterval min: 0 max: 1).
	self
		assert: childA constraints grid vertical spec span
		equals: (BlGridLayoutInterval min: 0 max: 1).

	self
		assert: childB constraints grid horizontal spec span
		equals: (BlGridLayoutInterval min: 0 max: 1).
	self
		assert: childB constraints grid vertical spec span
		equals: (BlGridLayoutInterval min: 1 max: 2).

	self
		assert: childC constraints grid horizontal spec span
		equals: (BlGridLayoutInterval min: 0 max: 1).
	self
		assert: childC constraints grid vertical spec span
		equals: (BlGridLayoutInterval min: 2 max: 3).

	^ parent
]

{ #category : #tests }
BlGridLayoutTest >> testExampleSpanDistributeOneRow [

	<sampleInstance>
	<demo>
	| parent childA childB childC |
	childA := self testChildElementMatchingParent.
	childB := self testChildElementMatchingParent.
	childC := self testChildElementMatchingParent.

	parent := self testParentWithGridHorizontalLayout.
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 400.
	parent layout rowCount: 1.

	parent addChildren: {
			childA.
			childB.
			childC }.
	parent forceLayout.

	self
		assert: childA constraints grid horizontal spec span
		equals: (BlGridLayoutInterval min: 0 max: 1).
	self
		assert: childA constraints grid vertical spec span
		equals: (BlGridLayoutInterval min: 0 max: 1).

	self
		assert: childB constraints grid horizontal spec span
		equals: (BlGridLayoutInterval min: 1 max: 2).
	self
		assert: childB constraints grid vertical spec span
		equals: (BlGridLayoutInterval min: 0 max: 1).

	self
		assert: childC constraints grid horizontal spec span
		equals: (BlGridLayoutInterval min: 2 max: 3).
	self
		assert: childC constraints grid vertical spec span
		equals: (BlGridLayoutInterval min: 0 max: 1).
	^ parent
]

{ #category : #tests }
BlGridLayoutTest >> testParentWithGridHorizontalLayout [

	<sampleInstance>
	<demo>
	| element |
	element := BlElement new
		           border: (BlBorder builder
				            dashed;
				            paint: Color red;
				            width: 3;
				            build);
		           layout: BlGridLayout horizontal.

	self assert: element layout class equals: BlGridLayout.

	^ element
]
