"
I am text paragraph measurer. I keep track of available width, height, current measuring position.

"
Class {
	#name : #BlTextParagraphMeasurer,
	#superclass : #Object,
	#instVars : [
		'maxHeight',
		'maxWidth',
		'textPosition',
		'line'
	],
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #'instance creation' }
BlTextParagraphMeasurer class >> newFor: aBlTextParagraph [

	^ self basicNew
		initializeWith: aBlTextParagraph;
		yourself
]

{ #category : #accessing }
BlTextParagraphMeasurer >> accumulatedHeight [

	^ line height
]

{ #category : #accessing }
BlTextParagraphMeasurer >> accumulatedWidth [

	^ line width
]

{ #category : #'geometry - accessing' }
BlTextParagraphMeasurer >> availableHeight [

	^ maxHeight - self accumulatedHeight
]

{ #category : #'geometry - accessing' }
BlTextParagraphMeasurer >> availableWidth [

	^ maxWidth - self accumulatedWidth
]

{ #category : #'measurement - testing' }
BlTextParagraphMeasurer >> hasAvailableSpace [
	"Return true if I have space available for more spans, false otherwise"

	^ self availableWidth > 0 and: [ self availableHeight > 0 ]
]

{ #category : #initialization }
BlTextParagraphMeasurer >> initializeWith: aBlTextParagraph [ 

	self initialize.
	
	maxWidth := aBlTextParagraph maxWidth.
	maxHeight := aBlTextParagraph maxHeight.

	textPosition := 0.

	line := BlTextParagraphLine new.
	line paragraph: aBlTextParagraph.

]

{ #category : #accessing }
BlTextParagraphMeasurer >> line [

	^ line
]

{ #category : #'paragraph - properties' }
BlTextParagraphMeasurer >> maxHeight [

	^ maxHeight
]

{ #category : #'paragraph - properties' }
BlTextParagraphMeasurer >> maxWidth [

	^ maxWidth
]

{ #category : #measurement }
BlTextParagraphMeasurer >> measureSpan: aBlSpan of: aTextParagraph with: aBlHostTextMeasurer [

	| aParagraphSpan |
	aParagraphSpan := aBlHostTextMeasurer measureTextSpan: aBlSpan.
	aParagraphSpan span: aBlSpan.

	aParagraphSpan
		text: aTextParagraph text
		from: self textStart
		to: ((self textStart + aBlSpan size - 1) max: 0).

	self pushSpan: aParagraphSpan
]

{ #category : #accessing }
BlTextParagraphMeasurer >> movePosition: aNumber [

	textPosition := aNumber
]

{ #category : #'text - accessing' }
BlTextParagraphMeasurer >> position [

	^ textPosition
]

{ #category : #accessing }
BlTextParagraphMeasurer >> pushPosition: aNumber [

	textPosition := textPosition + aNumber
]

{ #category : #adding }
BlTextParagraphMeasurer >> pushSpan: aParagraphSpan [

	line addSpan: aParagraphSpan.

	"and move text position"
	self pushPosition: aParagraphSpan spanLength - 1
]

{ #category : #'text - accessing' }
BlTextParagraphMeasurer >> textPosition [

	^ textPosition
]

{ #category : #'text - accessing' }
BlTextParagraphMeasurer >> textStart [

	^ self textPosition
]
