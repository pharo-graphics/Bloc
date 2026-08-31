"
I have been automatically converted and probably manually tweaked from BlWrapAroundChildrenLayoutExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlWrapAroundChildrenLayoutTest,
	#superclass : #TestCase,
	#category : #'Bloc-Layout-Tests'
}

{ #category : #running }
BlWrapAroundChildrenLayoutTest >> childExtent [

	^ 20 @ 20
]

{ #category : #running }
BlWrapAroundChildrenLayoutTest >> childPositions [

	^ {  (150 @ 50).
		  (50 @ 150).
		  (250 @ 250) }
]

{ #category : #running }
BlWrapAroundChildrenLayoutTest >> newContainerWithChildren [

	<demo>
	| aContainer |
	aContainer := BlElement new
		              layout: (BlWrapAroundChildrenLayout new
				               addLayout: BlBasicNodeBasedLayout new;
				               yourself);
		              constraintsDo: [ :c |
			              c horizontal fitContent.
			              c vertical fitContent ];
		              padding: (BlInsets all: 20);
		              background: Color gray;
		              yourself.

	self childPositions do: [ :each |
		aContainer addChild: (BlElement new
				 position: each;
				 background: Color blue;
				 extent: self childExtent;
				 yourself) ].
	
	^ aContainer
]

{ #category : #tests }
BlWrapAroundChildrenLayoutTest >> testNotTransformedContainerWrapsAroundChildren [

	| aContainer |
	aContainer := self newContainerWithChildren.

	aContainer forceLayout.

	self
		assert: aContainer bounds asRectangle
		equals: (30 @ 30 extent: 260 @ 260).
	self
		assert: aContainer boundsInSpace 
		equals: (30 @ 30 extent: 260 @ 260).

	aContainer children asArray
		with: self childPositions
		do: [ :eachChild :eachPosition |
			self
				assert: eachChild boundsInSpace
				equals: (eachPosition extent: self childExtent) ]
]

{ #category : #tests }
BlWrapAroundChildrenLayoutTest >> testScaledContainerWrapsAroundChildren [

	| aContainer |
	aContainer := self newContainerWithChildren.

	aContainer transformDo: [ :t | t scaleBy: 0.5 ].

	aContainer forceLayout.

	self
		assert: aContainer bounds asRectangle
		equals: ((30 @ 30) negated extent: 260 @ 260).
	self
		assert: aContainer boundsInSpace
		equals: (35 @ 35 extent: 130 @ 130).

	aContainer children asArray
		with: self childPositions
		do: [ :eachChild :eachPosition |
			self
				assert: eachChild boundsInSpace
				equals:
					(aContainer padding topLeft + (eachPosition / 2)
						extent: (self childExtent / 2)) ]
]
