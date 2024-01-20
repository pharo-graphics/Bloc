"
I exemplify {{gtClass:BlDevScripter}}.

"
Class {
	#name : #BlDevScripterExamplesTest,
	#superclass : #TestCase,
	#instVars : [
		'elementExamples'
	],
	#category : #'Bloc-Scripter-Examples'
}

{ #category : #running }
BlDevScripterExamplesTest >> newContainer [

	^ BlElement new
		layout: BlFrameLayout new;
		size: 300 @ 300;
		background: Color white;
		border: (BlBorder paint: Color blue width: 2);
		yourself
]

{ #category : #running }
BlDevScripterExamplesTest >> newContainerWithRectangle [

	| anElement |
	anElement := self newContainer.
	anElement addChild: self newRectangle.
	^ anElement
]

{ #category : #running }
BlDevScripterExamplesTest >> newRectangle [

	^ BlElement new
		size: 100 @ 100;
		background: Color gray;
		border: (BlBorder paint: Color black width: 2);
		constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ];
		yourself
]

{ #category : #tests }
BlDevScripterExamplesTest >> testClickCheckFailure [

	| anElement aScripter found |
	anElement := self newContainerWithRectangle.
	aScripter := BlDevScripter new.
	aScripter element: anElement.

1halt.
	"Expect a click on the first child"
	aScripter check testClick onChildAt: 1.
	"But will do a click on the space's root"
	aScripter testClick onSpaceRoot.

	self should: [ aScripter syncPlay ] raise: AssertionFailure.

	"The root is the clicked element"
	found := false.
	aScripter events
		detect: [ :each | each isClick ]
		ifFound: [ :event |
			found := true.
			self assert: event target equals: anElement space root ]
		ifNone: [ self fail ].
	self assert: found
]

{ #category : #tests }
BlDevScripterExamplesTest >> testClickCheckSuccess [

	| anElement aScripter found |
	anElement := self newContainerWithRectangle.
	aScripter := BlDevScripter new.
	aScripter element: anElement.

	aScripter check testClick onChildAt: 1.
	aScripter testClick onChildAt: 1.
	aScripter syncPlay.

	found := false.
	aScripter events
		detect: [ :each | each isClick ]
		ifFound: [ :event |
			found := true.
			self assert: event target equals: (anElement childAt: 1) ]
		ifNone: [ self fail ].
	self assert: found
]

{ #category : #tests }
BlDevScripterExamplesTest >> testSyncPlayProducesClick [

	| anElement aScripter |
	anElement := self newContainerWithRectangle.
	aScripter := BlDevScripter new.
	aScripter element: anElement.
	aScripter testClick onChildAt: 1.

	self assert: aScripter events isEmpty.
	aScripter syncPlay.
	self assert: (aScripter events asArray anySatisfy: [ :each | each isClick ])
]
