Class {
	#name : #BlMultiLineTextParagraph,
	#superclass : #BlTextParagraph,
	#instVars : [
		'lines',
		'offset'
	],
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #'paragraph - measuring' }
BlMultiLineTextParagraph >> basicMeasureOn: aSpanMeasurer [
	"Measure and create lines with text spans from provided text based on attributes and layout properties (maximum width / height)"
	| anIterator aMeasurer |

	aMeasurer := self createMeasurer.
	aMeasurer line paragraph: self.

	(self text isEmpty) ifTrue: [ 
		aMeasurer
			measureSpan: (BlSpan text: self text empty attributes: #())
			of: self
			with: aSpanMeasurer ].

	anIterator := text iterator.
	[ anIterator hasNext and: [ lines last isEmpty or: [ aMeasurer hasAvailableSpace ] ] ] whileTrue: [ 
		"If we pass #hasNext check we will definitely move to the next span,
		so can do the same with position"
		aMeasurer movePosition: anIterator position + 1.
		aMeasurer
			measureSpan: anIterator nextSpan
			of: self
			with: aSpanMeasurer ].

	"measurer creates a line with baseline set to 0@0"
	lines := aMeasurer lines.
	end := lines last to
]

{ #category : #initialization }
BlMultiLineTextParagraph >> defaultMeasurer [
	^ BlMultiLineTextParagraphMeasurer new
		offset: self offset
]

{ #category : #initialization }
BlMultiLineTextParagraph >> initialize [
	super initialize.
	
	offset := 0@0
]

{ #category : #accessing }
BlMultiLineTextParagraph >> lines [
	^ lines
]

{ #category : #accessing }
BlMultiLineTextParagraph >> offset [
	^ offset
]

{ #category : #accessing }
BlMultiLineTextParagraph >> offset: anObject [
	offset := anObject
]
