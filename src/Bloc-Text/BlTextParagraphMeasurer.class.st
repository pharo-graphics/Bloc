"
I am text paragraph measurer. I keep track of available width, height, current measuring position.

Additionally, depending on a paragraph type I may collect lines or spans. This behaviour should be inplemented in my paragraph sepecific subclass.
"
Class {
	#name : #BlTextParagraphMeasurer,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'maxHeight',
		'maxWidth',
		'textPosition'
	],
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #accessing }
BlTextParagraphMeasurer >> accumulatedHeight [
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BlTextParagraphMeasurer >> accumulatedWidth [
	<return: #Number>
	
	^ self subclassResponsibility
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
	<return: #Boolean>

	^ self availableWidth > 0
]

{ #category : #initialization }
BlTextParagraphMeasurer >> initialize [
	super initialize.
	
	maxWidth := Float infinity.
	maxHeight := Float infinity.
	textPosition := 0
]

{ #category : #'paragraph - properties' }
BlTextParagraphMeasurer >> maxHeight [
	^ maxHeight
]

{ #category : #'paragraph - properties' }
BlTextParagraphMeasurer >> maxHeight: aNumber [
	maxHeight := aNumber
]

{ #category : #'paragraph - properties' }
BlTextParagraphMeasurer >> maxWidth [
	^ maxWidth
]

{ #category : #'paragraph - properties' }
BlTextParagraphMeasurer >> maxWidth: aNumber [
	maxWidth := aNumber
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
BlTextParagraphMeasurer >> pushSpan: aSpan [
	self subclassResponsibility
]

{ #category : #'text - accessing' }
BlTextParagraphMeasurer >> textPosition [
	^ textPosition
]

{ #category : #'text - accessing' }
BlTextParagraphMeasurer >> textSize [
	^ self text size
]

{ #category : #'text - accessing' }
BlTextParagraphMeasurer >> textStart [
	^ self textPosition
]
