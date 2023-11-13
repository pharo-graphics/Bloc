Class {
	#name : #BlTextElementExamples,
	#superclass : #TestCase,
	#category : #'Bloc-Text-Alexandrie-Examples'
}

{ #category : #example }
BlTextElementExamples >> helloText [

	<sampleInstance>
	^ 'mama' asRopedText fontSize: 80
]

{ #category : #example }
BlTextElementExamples >> loremIpsumText [

	<sampleInstance>
	^ (String loremIpsum: 50) asRopedText
]

{ #category : #example }
BlTextElementExamples >> simpleText [

	<sampleInstance>
	| text textElement |
	text := (String loremIpsum: 50) asRopedText.
	textElement := BlTextElement new.
	textElement text: text.
	textElement background: Color paleYellow.
	textElement padding: (BlInsets all: 20).
	^ textElement
]

{ #category : #example }
BlTextElementExamples >> textAttributes [

	<sampleInstance>
	| text lineElements textElement |
	text := ('Hello world!' , String cr , 'How are you?') asRopedText.
	text
		fontSize: 16;
		italic. "emphasis"
	(text from: 1 to: 12)
		foreground: Color red;
		"weight"bold;
		"emphasis"normal. "text color"
	(text from: 13 to: text size)
		fontSize: 20;
		monospace. "font-family"

	lineElements := Array streamContents: [ :aStream |
		                | anIterator |
		                anIterator := text iterator.
		                [ anIterator hasNext ] whileTrue: [
			                aStream nextPut:
				                (BlTextElement text: anIterator nextLine) ] ].

	textElement := BlElement new
		               layout: BlLinearLayout vertical;
		               constraintsDo: [ :c |
			               c horizontal fitContent.
			               c vertical fitContent ];
		               addChildren: lineElements;
		               yourself.

	^ textElement
]
