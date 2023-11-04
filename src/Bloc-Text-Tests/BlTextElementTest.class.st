"
I have been automatically converted and probably manually tweaked from BlTextElementExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlTextElementTest,
	#superclass : #TestCase,
	#category : #'Bloc-Text-Tests'
}

{ #category : #metadata }
BlTextElementTest >> originClassName [
	"This test was generated from..."

	^ 'BlTextElementExamples'
]

{ #category : #tests }
BlTextElementTest >> testHelloText [

	<sampleInstance>
	^ 'mama' asRopedText fontSize: 80
]

{ #category : #tests }
BlTextElementTest >> testLoremIpsumText [

	<sampleInstance>
	^ (String loremIpsum: 50) asRopedText
]

{ #category : #tests }
BlTextElementTest >> testSimpleText [

	<sampleInstance>
	| text textElement |
	text := BlRopedText string: (String loremIpsum: 50).
	textElement := BlTextElement new.
	textElement text: text.
	textElement background: Color paleYellow.
	textElement padding: (BlInsets all: 20).
	^ textElement
]

{ #category : #tests }
BlTextElementTest >> testTextAttributes [

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

{ #category : #tests }
BlTextElementTest >> testTextElement [

	<sampleInstance>
	| text textElement |
	text := self testHelloText.
	textElement := BlTextElement new.
	textElement text: text.
	textElement clipChildren: false.
	self assert: textElement text equals: text.
	^ textElement
]
