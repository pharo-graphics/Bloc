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

{ #category : #'examples - scripter' }
BlDevScripterExamplesTest >> testBasicScripter [

	| aScript |
	aScript := BlDevScripter new.
	self assert: aScript events class equals: BlDevScripterEvents.
	self assert: aScript events isEmpty.

]

{ #category : #'examples - click check' }
BlDevScripterExamplesTest >> testClickCheck [

	| anElement aScripter |
	anElement := BlDevElementExamples new containerWithRectangle.
	aScripter := BlDevScripter new.
	aScripter element: anElement.
	aScripter testClick onChildAt: 1.
	aScripter check testClick onChildAt: 1.

	self deny: (aScripter events asArray anySatisfy: [ :each | each isClick ]).
	aScripter syncPlay.
	self assert: (aScripter events asArray anySatisfy: [ :each | each isClick ]).
	aScripter events
		detect: [ :each | each isClick ]
		ifFound: [ :event | event target = anElement ]
		ifNone: [ self fail ]

]

{ #category : #'examples - click check' }
BlDevScripterExamplesTest >> testFailingClickCheck [

	| anElement aScripter aScriptFailed |
	anElement := BlDevElementExamples new containerWithRectangle.

	aScripter := BlDevScripter new.
	aScripter element: anElement.

	"Expect a click on the first child"
	aScripter testClick onChildAt: 1.
	"But will do a click on the space's root"
	aScripter check testClick.

	aScriptFailed := false.
	[ aScripter syncPlay ]
		on: AssertionFailure
		do: [ :anException | aScriptFailed := true ].

	self assert: aScriptFailed description: 'The script must fail'.

	"The root is the clicked element"
	aScripter events
		detect: [ :each | each isClick ]
		ifFound: [ :event | event target = anElement space root ]
		ifNone: [ self fail ]

]
