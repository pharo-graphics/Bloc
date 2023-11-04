Class {
	#name : 'BlProportionalLayoutTest',
	#superclass : 'TestCase',
	#category : 'Bloc-Layout-Tests',
	#package : 'Bloc-Layout-Tests'
}

{ #category : 'tests' }
BlProportionalLayoutTest >> testDefaultConstraints [

	| aContainer aChild |
	aChild := BlElement new
		id: #child;
		yourself.

	aContainer := BlElement new
		id: #container;
		layout: BlProportionalLayout new;
		size: 210 @ 110;
		addChild: aChild;
		padding: (BlInsets all: 5);
		yourself.
	
	aChild requestLayout.
	aContainer forceLayout.
	
	self assert: aContainer extent equals: 210@110.
	self assert: aChild position equals: 5@5.
	self assert: aChild extent equals: 200@100.
	self
		assert: aChild constraints proportional horizontal left
		equals: 0.0.
	self
		assert: aChild constraints proportional vertical top
		equals: 0.0.
	self
		assert: aChild constraints proportional horizontal right
		equals: 1.0.
	self
		assert: aChild constraints proportional vertical bottom
		equals: 1.0
]

{ #category : 'tests' }
BlProportionalLayoutTest >> testFullMathsConsideringPaddingAndMargin [

	| aContainer aChild childFractions childMargin containerPadding containerExtent childMaxWidth childMaxHeight |
	containerExtent := 210 @ 110.
	containerPadding := BlInsets top: 3 left: 5 bottom: 7 right: 11.
	childMargin := BlInsets top: 13 left: 17 bottom: 19 right: 23.
	childFractions := BlInsets top: 0.1 left: 0.2 bottom: 0.8 right: 0.9.

	aChild := BlElement new
		id: #child;
		constraintsDo: [ :c |

			c margin: childMargin.

			c proportional horizontal
				left: childFractions left;
				right: childFractions right.

			c proportional vertical
				top: childFractions top;
				bottom: childFractions bottom ];

		yourself.

	aContainer := BlElement new
		id: #container;
		layout: BlProportionalLayout new;
		size: containerExtent;
		addChild: aChild;
		padding: containerPadding;
		yourself.

	aChild requestLayout.
	aContainer forceLayout.

	self assert: aContainer extent equals: containerExtent.

	childMaxWidth := containerExtent x - containerPadding left - containerPadding right - childMargin left - childMargin right.
	childMaxHeight := containerExtent y - containerPadding top - containerPadding bottom - childMargin top - childMargin bottom.

	self
		assert: aChild bounds inParent topLeft "=aChild position"
		equals:
			(containerPadding left + childMargin left + (childMaxWidth * childFractions left)) floor @
			(containerPadding top + childMargin top + (childMaxHeight * childFractions top)) floor.

	self
		assert: aChild bounds inParent bottomRight
		equals:
			(containerExtent x - containerPadding right - childMargin right - (childMaxWidth * (1 - childFractions right))) ceiling @
			(containerExtent y - containerPadding bottom - childMargin bottom - (childMaxHeight * (1 - childFractions bottom))) ceiling
]

{ #category : 'tests' }
BlProportionalLayoutTest >> testHorizontalAndVerticalConstraints [

	| aContainer aChild |
	aChild := BlElement new
		id: #child;
		constraintsDo: [ :c |
			c proportional horizontal
				left: 0.1;
				right: 0.9.
			c proportional vertical
				top: 0.2;
				bottom: 0.8 ];
			yourself.

	aContainer := BlElement new
		id: #container;
		layout: BlProportionalLayout new;
		size: 100 @ 100;
		addChild: aChild;
		yourself.
	
	aChild requestLayout.
	aContainer forceLayout.
	
	self assert: aChild position equals: 10@20.
	self assert: aChild extent equals: 80@60
]

{ #category : 'tests' }
BlProportionalLayoutTest >> testIgnoreByLayoutChild [

	| aContainer aChild |
	aChild := BlElement new
		id: #child;
		size: 10 @ 20;
		margin: (BlInsets all: 2); "This is taken into account"
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignLeft.
			c ignored vertical alignBottom ];
		yourself.

	aContainer := BlElement new
		id: #container;
		size: 200 @ 100;
		padding: (BlInsets all: 5); "This won't be taken into account"
		layout: BlProportionalLayout new;
		addChild: aChild;
		yourself.
	
	aContainer forceLayout.

	self assert: aChild position equals: 2 @ 78.
	self assert: aChild extent equals: 10 @ 20
]

{ #category : 'tests' }
BlProportionalLayoutTest >> testMultipleChildren [

	| aContainer childA childB |
	childA := BlElement new
		id: #childA;
		constraintsDo: [ :c |
			c proportional horizontal right: 0.5 ];
		yourself.

	childB := BlElement new
		id: #childB;
		constraintsDo: [ :c |
			c proportional horizontal left: 0.5 ];
		yourself.

	aContainer := BlElement new
		id: #container;
		layout: BlProportionalLayout new;
		size: 100 @ 100;
		addChild: childA;
		addChild: childB;
		yourself.
	
	childA requestLayout.
	childB requestLayout.
	aContainer forceLayout.
	
	self assert: childA position equals: 0@0.
	self assert: childA extent equals: 50@100.

	self assert: childB position equals: 50@0.
	self assert: childB extent equals: 50@100
]
