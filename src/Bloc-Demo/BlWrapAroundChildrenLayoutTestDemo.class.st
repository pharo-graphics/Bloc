Class {
	#name : #BlWrapAroundChildrenLayoutTestDemo,
	#superclass : #TestCase,
	#category : #'Bloc-Demo-FromTests'
}

{ #category : #'tests - demo' }
BlWrapAroundChildrenLayoutTestDemo >> container [

	<sampleInstance>
	^ BlElement new
		  layout:
			  (BlWrapAroundChildrenLayout new addLayout:
					   BlBasicNodeBasedLayout new);
		  constraintsDo: [ :c |
			  c horizontal fitContent.
			  c vertical fitContent ];
		  padding: (BlInsets all: 20);
		  background: (Color gray alpha: 0.2)
]

{ #category : #'tests - demo' }
BlWrapAroundChildrenLayoutTestDemo >> node [

	<sampleInstance>
	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		  border: (BlBorder paint: Color black width: 2);
		  background: Color white;
		  size: 20 @ 20
]

{ #category : #'tests - demo' }
BlWrapAroundChildrenLayoutTestDemo >> testContainerScaledWithNodes [

	<sampleInstance>
	| aContainer aChildA aChildB aChildC |
	aContainer := self container.
	aContainer transformDo: [ :t | t scaleBy: 0.5 ].
	aContainer addChild: (aChildA := self node position: 150 @ 50).
	aContainer addChild: (aChildB := self node position: 50 @ 150).
	aContainer addChild: (aChildC := self node position: 250 @ 250).

	aContainer forceLayout.
	self
		assert: aContainer bounds asRectangle
		equals: ((30 @ 30) negated extent: 260 @ 260).
	self
		assert: aChildA bounds asRectangle
		equals: (120 @ 20 extent: 20 @ 20).
	self
		assert: aChildB bounds asRectangle
		equals: (20 @ 120 extent: 20 @ 20).
	self
		assert: aChildC bounds asRectangle
		equals: (220 @ 220 extent: 20 @ 20).

	^ aContainer
]

{ #category : #'tests - demo' }
BlWrapAroundChildrenLayoutTestDemo >> testContainerWithNodes [

	<sampleInstance>
	| aContainer aChildA aChildB aChildC |
	aContainer := self container.
	aContainer addChild: (aChildA := self node position: 150 @ 50).
	aContainer addChild: (aChildB := self node position: 50 @ 150).
	aContainer addChild: (aChildC := self node position: 250 @ 250).

	aContainer forceLayout.
	self
		assert: aContainer bounds asRectangle
		equals: (30 @ 30 extent: 260 @ 260).
	self
		assert: aChildA bounds asRectangle
		equals: (120 @ 20 extent: 20 @ 20).
	self
		assert: aChildB bounds asRectangle
		equals: (20 @ 120 extent: 20 @ 20).
	self
		assert: aChildC bounds asRectangle
		equals: (220 @ 220 extent: 20 @ 20).

	^ aContainer
]
