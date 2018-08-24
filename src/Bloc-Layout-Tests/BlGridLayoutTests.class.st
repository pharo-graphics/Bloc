Class {
	#name : #BlGridLayoutTests,
	#superclass : #TestCase,
	#traits : 'TBlLayoutTests',
	#classTraits : 'TBlLayoutTests classTrait',
	#instVars : [
		'parent'
	],
	#category : 'Bloc-Layout-Tests-Grid'
}

{ #category : #running }
BlGridLayoutTests >> setUp [
	super setUp.
	
	parent := BlElement new.
	parent layout: BlGridLayout horizontal
]

{ #category : #running }
BlGridLayoutTests >> tearDown [
	super tearDown.
	
	parent := nil
]

{ #category : #'tests - unit - fill' }
BlGridLayoutTests >> testArrayFillEmpty [
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.
	
	grid fill: array from: 0 to: 1 with: 1.

	self assert: array equals: #()
]

{ #category : #'tests - unit - fill' }
BlGridLayoutTests >> testArrayFillFirstInFourElements [
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid fill: array from: 1 to: 2 with: 1.

	self assert: array equals: #(1 0 0 0)
]

{ #category : #'tests - unit - fill' }
BlGridLayoutTests >> testArrayFillForthInFourElements [
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid fill: array from: 4 to: 5 with: 1.

	self assert: array equals: #(0 0 0 1)
]

{ #category : #'tests - unit - fill' }
BlGridLayoutTests >> testArrayFillOneElement [
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 1 withAll: 0.
	
	grid fill: array from: 1 to: 2 with: 1.

	self assert: array equals: #(1)
]

{ #category : #'tests - unit - fill' }
BlGridLayoutTests >> testArrayFillOutOfBoundsEmpty1 [
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.
	
	self
		should: [ grid fill: array from: -1 to: 0 with: 1 ]
		raise: SubscriptOutOfBounds 
		description: 'Should raise SubscriptOutOfBounds' 
]

{ #category : #'tests - unit - fill' }
BlGridLayoutTests >> testArrayFillOutOfBoundsEmpty2 [
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.
	
	self
		should: [ grid fill: array from: -1 to: 1 with: 1 ]
		raise: SubscriptOutOfBounds 
		description: 'Should raise SubscriptOutOfBounds' 
]

{ #category : #'tests - unit - fill' }
BlGridLayoutTests >> testArrayFillOutOfBoundsEmpty3 [
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.
	
	self
		should: [ grid fill: array from: 1 to: 1 with: 1 ]
		raise: SubscriptOutOfBounds 
		description: 'Should raise SubscriptOutOfBounds' 
]

{ #category : #'tests - unit - fill' }
BlGridLayoutTests >> testArrayFillOutOfBoundsEmpty4 [
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 0 withAll: 0.
	
	self
		should: [ grid fill: array from: 0 to: 2 with: 1 ]
		raise: SubscriptOutOfBounds 
		description: 'Should raise SubscriptOutOfBounds' 
]

{ #category : #'tests - unit - fill' }
BlGridLayoutTests >> testArrayFillOutOfBoundsInFourElements1 [
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	self
		should: [ grid fill: array from: 0 to: 3 with: 1 ]
		raise: SubscriptOutOfBounds 
		description: 'Should raise SubscriptOutOfBounds' 
]

{ #category : #'tests - unit - fill' }
BlGridLayoutTests >> testArrayFillOutOfBoundsInFourElements2 [
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	self
		should: [ grid fill: array from: 1 to: 6 with: 1 ]
		raise: SubscriptOutOfBounds 
		description: 'Should raise SubscriptOutOfBounds' 
]

{ #category : #'tests - unit - fill' }
BlGridLayoutTests >> testArrayFillOutOfBoundsInFourElements3 [
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	self
		should: [ grid fill: array from: 4 to: 6 with: 1 ]
		raise: SubscriptOutOfBounds 
		description: 'Should raise SubscriptOutOfBounds' 
]

{ #category : #'tests - unit - fill' }
BlGridLayoutTests >> testArrayFillSecondInFourElements [
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid fill: array from: 2 to: 3 with: 1.

	self assert: array equals: #(0 1 0 0)
]

{ #category : #'tests - unit - fill' }
BlGridLayoutTests >> testArrayFillThreeElements [
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 3 withAll: 0.
	
	grid fill: array from: 1 to: 4 with: 1.

	self assert: array equals: #(1 1 1)
]

{ #category : #'tests - unit - fill' }
BlGridLayoutTests >> testArrayFillTwoElements [
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 2 withAll: 0.
	
	grid fill: array from: 1 to: 3 with: 1.

	self assert: array equals: #(1 1)
]

{ #category : #'tests - unit - fill' }
BlGridLayoutTests >> testArrayFillTwoInFourElements1 [
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid fill: array from: 1 to: 3 with: 1.

	self assert: array equals: #(1 1 0 0)
]

{ #category : #'tests - unit - fill' }
BlGridLayoutTests >> testArrayFillTwoInFourElements2 [
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid fill: array from: 2 to: 4 with: 1.

	self assert: array equals: #(0 1 1 0)
]

{ #category : #'tests - unit - fill' }
BlGridLayoutTests >> testArrayFillTwoInFourElements3 [
	| grid array |
	grid := BlGridLayoutImpl new.
	array := Array new: 4 withAll: 0.

	grid fill: array from: 3 to: 5 with: 1.

	self assert: array equals: #(0 0 1 1)
]

{ #category : #'tests - layout' }
BlGridLayoutTests >> testCellFitContent [
	| child subchild |

	parent constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical fitContent ].
	parent background: Color white.

	child := self matchWidthFitHeight.
	child layout: BlGridLayout vertical.
	child background: Color paleBlue.

	subchild := self exact: 200@100.
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

{ #category : #'tests - layout' }
BlGridLayoutTests >> testCellSpacingHorizontal1 [
	| childA childB |

	childA := self matchParent.
	childB := self matchParent.
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
]

{ #category : #'tests - layout' }
BlGridLayoutTests >> testCellSpacingVerical1 [
	| childA childB |

	childA := self matchParent.
	childB := self matchParent.
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
]

{ #category : #'tests - layout' }
BlGridLayoutTests >> testOneCellExactChildInExactParent [
	| child |
	
	child := self exact: 200@300.
	parent constraints horizontal exact: 300.
	parent constraints vertical exact: 400.

	parent addChild: child.
	parent forceLayout.

	self assert: child extent equals: 200@300.
	self assert: child position equals: 0@0.
	
	self assert: parent extent equals: 300@400.
	self assert: parent position equals: 0@0.
]

{ #category : #'tests - layout' }
BlGridLayoutTests >> testOneCellExactChildInFitParent [
	| child |
	
	child := self exact: 200@300.
	parent constraints horizontal fitContent.
	parent constraints vertical fitContent.

	parent addChild: child.
	parent forceLayout.

	self assert: child extent equals: 200@300.
	self assert: child position equals: 0@0.
	
	self assert: parent extent equals: 200@300.
	self assert: parent position equals: 0@0.
]

{ #category : #'tests - layout' }
BlGridLayoutTests >> testOneCellMatchChildInExactParent [
	| child |

	child := self matchParent.
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 300.

	parent addChild: child.
	parent forceLayout.

	self assert: child extent equals: 400@300.
	self assert: child position equals: 0@0.
	
	self assert: parent extent equals: 400@300.
	self assert: parent position equals: 0@0.
]

{ #category : #'tests - unit - spans' }
BlGridLayoutTests >> testSpanDistributeOneColumn [
	| childA childB childC |

	childA := self matchParent.
	childB := self matchParent.
	childC := self matchParent.
	
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 400.
	parent layout columnCount: 1.

	parent addChildren: { childA. childB. childC }.
	parent forceLayout.

	self assert: (childA constraints grid horizontal spec span) equals: (1 to: 2).
	self assert: (childA constraints grid vertical spec span) equals: (1 to: 2).
	
	self assert: (childB constraints grid horizontal spec span) equals: (1 to: 2).
	self assert: (childB constraints grid vertical spec span) equals: (2 to: 3).
	
	self assert: (childC constraints grid horizontal spec span) equals: (1 to: 2).
	self assert: (childC constraints grid vertical spec span) equals: (3 to: 4).
]

{ #category : #'tests - unit - spans' }
BlGridLayoutTests >> testSpanDistributeOneRow [
	| childA childB childC |

	childA := self matchParent.
	childB := self matchParent.
	childC := self matchParent.
	
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 400.
	parent layout rowCount: 1.

	parent addChildren: { childA. childB. childC }.
	parent forceLayout.

	self assert: (childA constraints grid horizontal spec span) equals: (1 to: 2).
	self assert: (childA constraints grid vertical spec span) equals: (1 to: 2).
	
	self assert: (childB constraints grid horizontal spec span) equals: (2 to: 3).
	self assert: (childB constraints grid vertical spec span) equals: (1 to: 2).
	
	self assert: (childC constraints grid horizontal spec span) equals: (3 to: 4).
	self assert: (childC constraints grid vertical spec span) equals: (1 to: 2).
]
