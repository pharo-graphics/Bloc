"
I contain examples of how to create and attribute a text model and then create a corresponding text element
"
Class {
	#name : #BlTextElementExamples,
	#superclass : #Object,
	#category : 'Bloc-Examples-Text'
}

{ #category : #example }
BlTextElementExamples >> simpleText [
	<gtExample>
	| text textElement |
	
	text := BlRopedText string: (String loremIpsum: 50).
	textElement := BlTextElement new.
	textElement text: text.
	textElement background: Color paleYellow.
	textElement padding: (BlInsets all: 20).
	^ textElement

]

{ #category : #example }
BlTextElementExamples >> textAttributes [
	<gtExample>
	| text textElement |

	text := BlRopedText string: 'Hello world!', String cr, 'How are you?'.
	text attributes: {
		BrFontSizeAttribute size: 16.
		BrFontEmphasisAttribute italic } from: 1 to: text size. "the whole text"
	text attributes: {
		BrTextForegroundAttribute paint: Color red.
		BrFontWeightAttribute bold.
		BrFontEmphasisAttribute normal } from: 1 to: 12. "Hello world!"
	text attributes: {
		BrFontSizeAttribute size: 20.
		BrFontGenericFamilyAttribute monospace  } from: 13 to: text size. "How are you?"
	textElement := BlTextElement new.
	textElement text: text.
	textElement background: Color paleYellow.
	^ textElement
]
