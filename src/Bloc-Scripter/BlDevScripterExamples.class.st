"
I exemplify {{gtClass:BlDevScripter}}.

"
Class {
	#name : #BlDevScripterExamples,
	#superclass : #BlExampleTest,
	#instVars : [
		'elementExamples'
	],
	#category : #'Bloc-Scripter-Examples'
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

{ #category : #'examples - click check' }
BlDevScripterExamples >> clickCheck [
<gtExample>
	| anElement aScript |
	anElement := BlDevElementExamples new containerWithRectangle.
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
	| anElement aScripter aScriptFailed |

	anElement := BlDevElementExamples new containerWithRectangle.

	aScripter := self basicScripter element: anElement.

	aScripter click onChildAt: 1.
	aScripter check click.

	aScriptFailed := false.
	[ aScripter syncPlay ] 
		on: AssertionFailure 
		do: [ :anException | aScriptFailed := true ].

	self assert: aScriptFailed description: 'The script must fail'.

	^ aScripter
]

{ #category : #initialization }
BlDevScripterExamples >> initialize [
	super initialize.
	elementExamples := BlDevElementExamples new.
]
