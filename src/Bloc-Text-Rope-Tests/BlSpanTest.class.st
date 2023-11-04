Class {
	#name : #BlSpanTest,
	#superclass : #TestCase,
	#category : #'Bloc-Text-Rope-Tests'
}

{ #category : #tests }
BlSpanTest >> testUtf8Encoded [

	| aString aSpan |
	aString := 'Hello World'.
	aSpan := BlSpan
		text: (BlRopedText string: aString)
		attributes: { BlTextForegroundAttribute paint: Color blue }.

	self
		assert: aSpan utf8Encoded
		equals: aString utf8Encoded

]
