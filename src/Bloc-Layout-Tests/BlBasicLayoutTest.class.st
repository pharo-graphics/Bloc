Class {
	#name : 'BlBasicLayoutTest',
	#superclass : 'TestCase',
	#instVars : [
		'space'
	],
	#category : 'Bloc-Layout-Tests',
	#package : 'Bloc-Layout-Tests'
}

{ #category : 'running' }
BlBasicLayoutTest >> setUp [
	super setUp.
	space := BlSpace new.
	space host: BlHeadlessHost new.
	space show; waitPendingWork
]

{ #category : 'running' }
BlBasicLayoutTest >> tearDown [
	space ifNotNil: [
		space close; waitPendingWork.
		space := nil ].
	super tearDown
]

{ #category : 'tests' }
BlBasicLayoutTest >> testForceLayoutOfMatchParent [

	<sampleInstance>
	<demo>
	| anElement |
	anElement := BlElement new.
	anElement border: (BlBorder paint: Color gray width: 2).
	anElement background: Color lightGray.
	anElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	space mutateSync: [ space root addChild: anElement ].
	self assert: anElement extent equals: 800 @ 600.
	^ anElement
]

{ #category : 'tests' }
BlBasicLayoutTest >> testParentWithChildExactExtent [

	<sampleInstance>
	<demo>
	| child parent |
	child := BlElement new.
	child layout: BlBasicLayout uniqueInstance.
	"The default layout of an element is already such instance so
	the expression is not needed."
	child background: (Color red alpha: 0.3).
	child border: (BlBorder paint: Color red width: 1).
	child constraintsDo: [ :c |
		c horizontal exact: 100.
		c vertical exact: 100 ].
	parent := BlElement new.
	parent layout: BlBasicLayout uniqueInstance.
	"The default layout of an element is already such instance so
	the expression is not needed."
	parent background: (Color gray alpha: 0.3).
	parent padding: (BlInsets all: 25).
	parent constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical exact: 300 ].
	parent addChild: child.
	space mutateSync: [ space root addChild: parent ].
	self assert: parent extent equals: 300 @ 300.
	self assert: child extent equals: 100 @ 100.
	^ parent
]

{ #category : 'tests' }
BlBasicLayoutTest >> testParentWithChildFitContent [

	<sampleInstance>
	<demo>
	| child parent |
	parent := self testParentWithChildExactExtent.
	child := parent children first.
	child constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	space mutateSync: [ space root addChild: parent ].
	self assert: parent extent equals: 300 @ 300.
	self assert: child extent equals: 0 @ 0.
	^ parent
]

{ #category : 'tests' }
BlBasicLayoutTest >> testParentWithChildMatchParent [

	<sampleInstance>
	<demo>
	| child parent |
	parent := self testParentWithChildExactExtent.
	child := parent children first.
	child constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	space mutateSync: [ space root addChild: parent ].
	self assert: parent extent equals: 300 @ 300.
	self assert: child extent equals: 300 @ 300.
	^ parent
]
