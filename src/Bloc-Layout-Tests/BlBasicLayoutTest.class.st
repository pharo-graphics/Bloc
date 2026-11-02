Class {
	#name : #BlBasicLayoutTest,
	#superclass : #TestCase,
	#category : #'Bloc-Layout-Tests'
}

{ #category : #helpers }
BlBasicLayoutTest >> newParentWithChild [

	| child parent |
	child :=
		BlElement new
			constraintsDo: [ :c |
				c horizontal exact: 100.
				c vertical exact: 100 ];
			yourself.
	parent :=
		BlElement new
			layout: BlBasicLayout new;
			constraintsDo: [ :c |
				c horizontal exact: 300.
				c vertical exact: 300 ];
			addChild: child;
			yourself.
	^ parent
]

{ #category : #tests }
BlBasicLayoutTest >> testForceLayoutOfMatchParent [

	| anElement |
	anElement :=
		BlElement new
			border: (BlBorder paint: Color gray width: 2);
			background: Color lightGray;
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ];
			yourself.

	anElement forceLayout.

	self assert: anElement extent equals: 800 @ 600
]

{ #category : #tests }
BlBasicLayoutTest >> testMeasureChildWithMarginsWhenChildHasNoParent [

	| layout child |
	layout := BlBasicLayout new.
	child :=
		BlElement new
			margin: (BlInsets all: 10);
			extent: 100 @ 100;
			yourself.

	layout
		measureChildWithMargins: child
		parentSpec: (BlExtentMeasurementSpec exact: 200 @ 200)
		widthUsed: 0
		heightUsed: 0.

	self assert: child measuredExtent equals: 100 @ 100
]

{ #category : #tests }
BlBasicLayoutTest >> testParentWithChildExactExtent [

	| parent child |
	parent := self newParentWithChild.
	child := parent children first.

	parent forceLayout.

	self assert: parent extent equals: 300 @ 300.
	self assert: child extent equals: 100 @ 100
]

{ #category : #tests }
BlBasicLayoutTest >> testParentWithChildFitContent [

	| parent child |
	parent := self newParentWithChild.
	child := parent children first.
	child constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].

	parent forceLayout.

	self assert: parent extent equals: 300 @ 300.
	self assert: child extent equals: 0 @ 0
]

{ #category : #tests }
BlBasicLayoutTest >> testParentWithChildMatchParent [

	| parent child |
	parent := self newParentWithChild.
	child := parent children first.
	child constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	parent forceLayout.

	self assert: parent extent equals: 300 @ 300.
	self assert: child extent equals: 300 @ 300
]
