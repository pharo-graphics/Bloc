Class {
	#name : #BlTextElementExamples,
	#superclass : #BlExamplesTest,
	#category : #'Bloc-Text-Alexandrie-Examples'
}

{ #category : #example }
BlTextElementExamples >> textWithOverlappedAttributes [
	<demo>
	<sampleInstance>

	| text lineElements textElement |
	text := ('Hello world!' , String cr , 'How are you?') asRopedText.
	text foreground: Color purple.
	text
		fontSize: 15;
		italic. "emphasis"
	(text from: 1 to: 16)
		foreground: Color red; "text color"
		bold; "weight"
		normal. "emphasis"
	(text from: 7 to: text size - 4)
		fontSize: 20;
		foreground: Color blue;
		monospace. "font-family"

	lineElements := Array streamContents: [ :aStream |
		| anIterator |
		anIterator := text iterator.
		[ anIterator hasNext ] whileTrue: [
			aStream nextPut:
				(BlTextElement text: anIterator nextLine) ] ].

	textElement :=
		BlElement new
			layout: BlLinearLayout vertical;
			constraintsDo: [ :c |
				c horizontal fitContent.
				c vertical fitContent ];
			addChildren: lineElements;
			yourself.

	^ textElement
]

{ #category : #example }
BlTextElementExamples >> textWithPadding [
	<demo>
	<sampleInstance>

	| text textElement |
	text := (String loremIpsum: 50) asRopedText.
	textElement := BlTextElement new.
	textElement text: text.
	textElement background: Color paleYellow.
	textElement padding: (BlInsets all: 20).
	^ textElement
]
