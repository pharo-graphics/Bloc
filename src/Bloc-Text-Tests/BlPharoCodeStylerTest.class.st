"
A BlPharoCodeStylerTest is a test class for testing the behavior of BlPharoCodeStyler
"
Class {
	#name : #BlPharoCodeStylerTest,
	#superclass : #TestCase,
	#category : #'Bloc-Text-Tests-Text-Styler'
}

{ #category : #tests }
BlPharoCodeStylerTest >> expectedFailures [

	^ SystemVersion current major < 12
		  ifTrue: [ #( testStyleMethod testStyleScript ) ]
		  ifFalse: [ #(  ) ]
]

{ #category : #tests }
BlPharoCodeStylerTest >> testStyleMethod [

	| styler method styledText attributes |
	method := Integer >> #bitAnd:.

	styler := BlPharoCodeStyler new.
	styler classOrMetaClass: method origin.
	
	styledText := styler style: method sourceCode asRopedText.

	attributes := Set new.
	(styledText from: 1 to: method sourceCode size)
		attributesDo: [ :each :index | attributes add: each ].

	self denyEmpty: attributes
]

{ #category : #tests }
BlPharoCodeStylerTest >> testStyleScript [

	| styler sourceCode styledText attributes |
	sourceCode := '1 + 2'.

	styler := BlPharoCodeStyler new.
	styler classOrMetaClass: nil.
	
	styledText := styler style: sourceCode asRopedText.

	attributes := Set new.
	(styledText from: 1 to: sourceCode size)
		attributesDo: [ :each :index | attributes add: each ].

	self denyEmpty: attributes
]
