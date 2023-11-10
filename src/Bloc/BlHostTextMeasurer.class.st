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
	#category : 'Bloc-Universe - Renderer'
}

{ #category : #measurement }
BlHostTextMeasurer >> measureTextParagraph: aBlTextParagraph [

	self subclassResponsibility
]

{ #category : #measurement }
BlHostTextMeasurer >> measureTextSpan: aBlTextSpan [

	self subclassResponsibility
]

{ #category : #'paragraph span instance creation' }
BlHostTextMeasurer >> newParagraphSpan [

	^ self subclassResponsibility
]

{ #category : #measurement }
BlHostTextMeasurer >> newParagraphSpanFor: aBlSpan [

	^ self newParagraphSpan
		  hostMeasurer: self;
		  span: aBlSpan;
		  measure;
		  yourself
]
