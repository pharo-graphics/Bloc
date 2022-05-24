Class {
	#name : #BlRopedTextTest,
	#superclass : #TestCase,
	#category : #'Bloc-Text-Rope-Tests'
}

{ #category : #tests }
BlRopedTextTest >> testDuplicatedAttributes [

	| text attributes |
	text := (BlRopedText string: 'asd')
		attributes:{
			BlTextForegroundAttribute paint: Color green. 
			BlTextForegroundAttribute paint: Color blue };
		yourself.

	attributes := text iterator attributes.
	self assert: attributes size equals: 1.
	self assert: attributes first paint equals: Color blue.
]

{ #category : #tests }
BlRopedTextTest >> testUTF8RopedText [

	| aString aRopedText |
	aString := 'Hello World'.
	aRopedText := (BlRopedText string: aString)
		foreground: Color red; "Just to add complexity"
		yourself.

	self
		assert: aRopedText utf8Encoded
		equals: aString utf8Encoded
]

{ #category : #tests }
BlRopedTextTest >> testUTF8SubRope [

	| aNumber aString aRopedText |
	aNumber := 7.
	aString := 'Hello World'.
	aRopedText := (BlRopedText string: aString)
		foreground: Color red; "Just to add complexity"
		yourself.

	self
		assert: (aRopedText first: aNumber) utf8Encoded
		equals: (aString first: aNumber) utf8Encoded

]
