Class {
	#name : #BlMultiLineTextParagraphMeasurer,
	#superclass : #BlTextParagraphMeasurer,
	#instVars : [
		'lines',
		'offset',
		'previousLineAccumulatedHeight',
		'accumulatedWidth',
		'accumulatedHeight'
	],
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #accessing }
BlMultiLineTextParagraphMeasurer >> accumulatedHeight [
	<return: #Number>

	^ accumulatedHeight
]

{ #category : #accessing }
BlMultiLineTextParagraphMeasurer >> accumulatedWidth [
	<return: #Number>

	^ accumulatedWidth
]

{ #category : #initialization }
BlMultiLineTextParagraphMeasurer >> initialize [
	super initialize.
		
	lines := OrderedCollection with: BlTextParagraphLine new.
	accumulatedHeight := 0.
	accumulatedWidth := 0.
	previousLineAccumulatedHeight := 0
]

{ #category : #accessing }
BlMultiLineTextParagraphMeasurer >> lines [
	^ lines
]

{ #category : #accessing }
BlMultiLineTextParagraphMeasurer >> offset [
	^ offset
]

{ #category : #accessing }
BlMultiLineTextParagraphMeasurer >> offset: anObject [
	offset := anObject
]

{ #category : #adding }
BlMultiLineTextParagraphMeasurer >> pushSpan: aParagraphSpan [
	self lines last isEmpty
		"if the last line is empty we add a new span there anyway"
		ifTrue: [
			self lines last addSpan: aParagraphSpan ]
		ifFalse: [
			(self lines last width + aParagraphSpan width) > self maxWidth
				ifTrue: [
					previousLineAccumulatedHeight := accumulatedHeight.
					lines add: (BlTextParagraphLine new addSpan: aParagraphSpan) ]
				ifFalse: [ self lines last addSpan: aParagraphSpan ] ].

	accumulatedHeight := previousLineAccumulatedHeight + self lines last height.
	accumulatedWidth := accumulatedWidth max: self lines last width.

	"and move text position"
	self pushPosition: aParagraphSpan spanLength - 1
]
