"
A BlSvgExamplesTest is a test class for testing the behavior of BlSvgExamples
"
Class {
	#name : #BlSvgExamplesTest,
	#superclass : #TestCase,
	#category : #'Bloc-SVG-Tests-Examples'
}

{ #category : #tests }
BlSvgExamplesTest >> exampleSelectors [

	^ BlSvgExamples selectorsInProtocol: 'svg - converter'
]

{ #category : #tests }
BlSvgExamplesTest >> testAllExamples [

	| selectors exampleFactory |
	selectors := self exampleSelectors.
	exampleFactory := BlSvgExamples new.

	selectors do: [ :each |
		| result |
		result := exampleFactory perform: each.
		self assert: (result isKindOf: BlElement) ].
	
	self deny: selectors isEmpty.
	
"	
	selectors collect: [ :each | each -> (BlSvgExamples new perform: each) ]
"
]
