Class {
	#name : #BlBasicLayoutTest,
	#superclass : #TestCase,
	#instVars : [
		'space'
	],
	#category : #'Bloc-Layout-Tests'
}

{ #category : #running }
BlBasicLayoutTest >> setUp [
	super setUp.
	space := BlSpace new.
	space host: BlHeadlessHost new.
	space show; waitPendingWork
]

{ #category : #running }
BlBasicLayoutTest >> tearDown [
	space ifNotNil: [
		space close; waitPendingWork.
		space := nil ].
	super tearDown
]

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

	space mutateSync: [ space root addChild: anElement ].

	self assert: anElement extent equals: 800 @ 600
]

{ #category : #tests }
BlBasicLayoutTest >> testParentWithChildExactExtent [

	| parent child |
	parent := self newParentWithChild.
	child := parent children first.

	space mutateSync: [ space root addChild: parent ].

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

	space mutateSync: [ space root addChild: parent ].

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

	space mutateSync: [ space root addChild: parent ].

	self assert: parent extent equals: 300 @ 300.
	self assert: child extent equals: 300 @ 300
]
