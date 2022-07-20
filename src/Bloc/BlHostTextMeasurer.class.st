"
My subclasses are canvas specific. They are responsible of measuring a text paragraph by an editor.
The result of measuring is an instance of a `BlTextParagraphLeaf` subclass (canvas specific).

Used mainly 
- to get an index in a text span from a 2D position
- to get a 2D position from a text span index

"
Class {
	#name : #BlHostTextMeasurer,
	#superclass : #Object,
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #dispatch }
BlHostTextMeasurer >> measureTextParagraph: aBlTextParagraph [
	self subclassResponsibility
]

{ #category : #dispatch }
BlHostTextMeasurer >> measureTextSpan: aBlTextSpan [
	self subclassResponsibility
]
