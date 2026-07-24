Class {
	#name : #BlDevScripterTest,
	#superclass : #TestCase,
	#instVars : [
		'scripter'
	],
	#category : #'Bloc-Scripter-Examples'
}

{ #category : #running }
BlDevScripterTest >> newContainer [

	^ BlElement new
		layout: BlFrameLayout new;
		extent: 300 @ 300;
		background: Color white;
		border: (BlBorder paint: Color blue width: 2);
		yourself
]

{ #category : #running }
BlDevScripterTest >> newContainerWithRectangle [

	| anElement |
	anElement := self newContainer.
	anElement addChild: self newRectangle.
	^ anElement
]

{ #category : #running }
BlDevScripterTest >> newRectangle [

	^ BlElement new
		background: Color red;
		constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ];
		yourself
]

{ #category : #running }
BlDevScripterTest >> setUp [

	super setUp.
	scripter := BlDevScripter new.
	scripter element: self newContainerWithRectangle
]

{ #category : #running }
BlDevScripterTest >> tearDown [

	scripter close.
	super tearDown
]

{ #category : #tests }
BlDevScripterTest >> testClickCheckFailure [

	| found |
	"Expect a click on the first child.
	But will do a click on the space's root"
	scripter click onSpaceRoot.
	scripter check click onChildAt: 1.

	self should: [ scripter syncPlay ] raise: AssertionFailure.

	"The root is the clicked element"
	found := false.
	scripter events
		detect: [ :each | each isClick ]
		ifFound: [ :event |
			found := true.
			self assert: event target equals: scripter element space root ]
		ifNone: [ self fail ].
	self assert: found
]

{ #category : #tests }
BlDevScripterTest >> testClickCheckSuccess [

	| found |
	scripter click onChildAt: 1.
	scripter check click onChildAt: 1.
	scripter syncPlay.

	found := false.
	scripter events
		detect: [ :each | each isClick ]
		ifFound: [ :event |
			found := true.
			self assert: event target equals: (scripter element childAt: 1) ]
		ifNone: [ self fail ].
	self assert: found
]

{ #category : #tests }
BlDevScripterTest >> testSyncPlayProducesClick [

	scripter click onChildAt: 1.

	self assert: scripter events isEmpty.
	scripter syncPlay.
	self assert: (scripter events asArray anySatisfy: [ :each | each isClick ])
]
