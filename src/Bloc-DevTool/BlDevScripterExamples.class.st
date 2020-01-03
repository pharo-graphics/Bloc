"
I exemplify ${class:BlDevScripter}$.
"
Class {
	#name : #BlDevScripterExamples,
	#superclass : #Object,
	#instVars : [
		'elementExamples'
	],
	#category : #'Bloc-DevTool-Examples'
}

{ #category : #'examples - scripter' }
BlDevScripterExamples >> basicScripter [
	<gtExample>
	| aScript |
	aScript := BlDevScripter new.
	self assert: aScript events class equals: BlDevScripterEvents.
	self assert: aScript events isEmpty.
	^ aScript
]

{ #category : #'examples - ui' }
BlDevScripterExamples >> basicStepElement [
	<gtExample>
	| anElement |
	anElement := BlDevScripterStepElement new.
	^ anElement
]

{ #category : #'examples - click check' }
BlDevScripterExamples >> clickCheck [
	<gtExample>
	| anElement aScript |
	anElement := BlDevHalosEventListenerExamples new containerWithRectangle.
	aScript := self basicScripter element: anElement.
	aScript click onChildAt: 1.
	aScript check click onChildAt: 1.
	aScript play.
	^ aScript
]

{ #category : #'examples - element' }
BlDevScripterExamples >> containerWithRectangle [
	<gtExample>
	^ elementExamples containerWithRectangle
]

{ #category : #'examples - click check' }
BlDevScripterExamples >> failingClickCheck [
	<gtExample>
	| anElement aScript aScriptFailed |
	anElement := BlDevHalosEventListenerExamples new containerWithRectangle.
	aScript := self basicScripter element: anElement.
	aScript click onChildAt: 1.
	aScript check click.
	aScriptFailed := false.
	[ aScript play ] 
		on: AssertionFailure 
		do: [ :anException | aScriptFailed := true ].
	self assert: aScriptFailed description: 'The script must fail'.
	^ aScript
]

{ #category : #initialization }
BlDevScripterExamples >> initialize [
	super initialize.
	elementExamples := BlDevElementExamples new.
]
