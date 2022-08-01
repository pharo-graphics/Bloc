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
		'line',
		'hostTextMeasurer'
	],
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #measurement }
BlTextParagraphMeasurer class >> hostTextMeasurer: aHostSpanMeasurer [
	^ self new hostTextMeasurer: aHostSpanMeasurer
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

{ #category : #measurement }
BlTextParagraphMeasurer >> emptySpan [
	^ BlSpan text: BlText empty attributes: #().
]

{ #category : #'measurement - testing' }
BlTextParagraphMeasurer >> hasAvailableSpace [
	"Return true if I have space available for more spans, false otherwise"

	^ self availableWidth > 0 and: [ self availableHeight > 0 ]
]

{ #category : #measurement }
BlTextParagraphMeasurer >> hostTextMeasurer: aBlHostTextMeasurer [

	hostTextMeasurer := aBlHostTextMeasurer.
	self measureSpan: self emptySpan.
]

{ #category : #initialization }
BlTextParagraphMeasurer >> initialize [

	maxWidth := Float infinity.
	maxHeight := Float infinity.

	textPosition := 0.

	line := BlTextParagraphLine new
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
BlTextParagraphMeasurer >> maxHeight: aFloat [

	maxHeight := aFloat
]

{ #category : #'paragraph - properties' }
BlTextParagraphMeasurer >> maxWidth [

	^ maxWidth
]

{ #category : #'paragraph - properties' }
BlTextParagraphMeasurer >> maxWidth: aFloat [
	maxWidth := aFloat
]

{ #category : #measurement }
BlTextParagraphMeasurer >> measureSpan: aBlSpan [

	| aParagraphSpan |
	aParagraphSpan := hostTextMeasurer measureTextSpan: aBlSpan.
	aParagraphSpan
		from: textPosition
		to: ((textPosition + aBlSpan size - 1) max: 0).

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
