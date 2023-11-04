"
A BlSvgExamplesTest is a test class for testing the behavior of BlSvgExamples
"
Class {
	#name : 'BlSvgExamplesTest',
	#superclass : 'TestCase',
	#category : 'Bloc-SVG-Tests-Examples',
	#package : 'Bloc-SVG-Tests',
	#tag : 'Examples'
}

{ #category : 'tests' }
BlSvgExamplesTest >> exampleSelectors [

	^ (BlSvgExamples selectorsInProtocol: 'svg - converter') 
		  copyWithoutAll: self exampleSelectorsWithErrors
]

{ #category : 'tests' }
BlSvgExamplesTest >> exampleSelectorsWithErrors [
	
	^ #( pathTree transformations)
]

{ #category : 'tests' }
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

{ #category : 'tests' }
BlSvgExamplesTest >> testExcludedExamplesRaiseError [

	| selectors exampleFactory |
	selectors := self exampleSelectorsWithErrors.
	exampleFactory := BlSvgExamples new.

	selectors do: [ :each |
		self
			should:[ (exampleFactory perform: each) aeAsForm ]
			raise: Error ].
	
	self deny: selectors isEmpty. "If this happens, we must remove this test"

]
