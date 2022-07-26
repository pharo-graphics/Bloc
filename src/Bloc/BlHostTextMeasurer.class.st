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
	#instVars : [
		'aeCanvas'
	],
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #accessing }
BlHostTextMeasurer >> canvas [

	^ aeCanvas
]

{ #category : #measurement }
BlHostTextMeasurer >> createParagraphSpan [
	<return: #BlSpartaTextParagraphSpan>

	^ self newParagraphSpan 
		  measurer: self;
		  yourself
]

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
