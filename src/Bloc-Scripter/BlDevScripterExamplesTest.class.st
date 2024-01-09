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

{ #category : #'examples - click check' }
BlDevScripterExamplesTest >> clickCheck [

	<sampleInstance>
	| anElement aScript |
	anElement := BlDevElementExamples new containerWithRectangle.
	aScript := self testBasicScripter element: anElement.
	aScript testClick onChildAt: 1.
	aScript check testClick onChildAt: 1.
	aScript play.
	^ aScript
]

{ #category : #'examples - element' }
BlDevScripterExamplesTest >> containerWithRectangle [

	<sampleInstance>
	^ elementExamples containerWithRectangle
]

{ #category : #initialization }
BlDevScripterExamplesTest >> initialize [
	super initialize.
	elementExamples := BlDevElementExamples new.
]

{ #category : #'examples - scripter' }
BlDevScripterExamplesTest >> testBasicScripter [

	<sampleInstance>
	| aScript |
	aScript := BlDevScripter new.
	self assert: aScript events class equals: BlDevScripterEvents.
	self assert: aScript events isEmpty.
	^ aScript
]

{ #category : #'examples - click check' }
BlDevScripterExamplesTest >> testFailingClickCheck [

	<sampleInstance>
	| anElement aScripter aScriptFailed |
	anElement := BlDevElementExamples new containerWithRectangle.

	aScripter := self testBasicScripter element: anElement.

	aScripter testClick onChildAt: 1.
	aScripter check testClick.

	aScriptFailed := false.
	[ aScripter syncPlay ]
		on: AssertionFailure
		do: [ :anException | aScriptFailed := true ].

	self assert: aScriptFailed description: 'The script must fail'.

	^ aScripter
]
