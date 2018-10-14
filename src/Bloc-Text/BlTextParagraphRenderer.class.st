"
I define an API of a paragraph renderer.
Users should sublcass me in order to implement backend specific renderers.

Note: definition #render:on: accepts any kind of canvas, however every concrete renderer implementation expects a very specific canvas. Using backend specific renderers with wrong canvas resuls in undefined behaviour.

Public API and Key Messages

- render:on: renders a given text paragraph on a provided canvas
"
Class {
	#name : #BlTextParagraphRenderer,
	#superclass : #Object,
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #rendering }
BlTextParagraphRenderer >> render: aBrTextParagraph on: aCanvas [
	"Render a given text paragraph on a provided canvas.
	aBrTextParagraph must not be nil.
	aCanvas must not be nil"

	self subclassResponsibility
]

{ #category : #rendering }
BlTextParagraphRenderer >> renderSelection: aBrTextParagraph on: aCanvas [
	"Render a selection of a given text paragraph on a provided canvas.
	aBrTextParagraph must not be nil.
	aCanvas must not be nil"
	
	self subclassResponsibility
]
