Class {
	#name : #BlSingleLineTextParagraphMeasurer,
	#superclass : #BlTextParagraphMeasurer,
	#instVars : [
		'line'
	],
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #accessing }
BlSingleLineTextParagraphMeasurer >> accumulatedHeight [
	<return: #Number>

	^ self line height
]

{ #category : #accessing }
BlSingleLineTextParagraphMeasurer >> accumulatedWidth [
	<return: #Number>

	^ self line width
]

{ #category : #initialization }
BlSingleLineTextParagraphMeasurer >> initialize [
	super initialize.
		
	line := BlTextParagraphLine new
]

{ #category : #accessing }
BlSingleLineTextParagraphMeasurer >> line [
	^ line
]

{ #category : #adding }
BlSingleLineTextParagraphMeasurer >> pushSpan: aParagraphSpan [
	self line addSpan: aParagraphSpan.
	
	"after pushing a new span, we should also move glyphs start index"
	textRunStart := textRunEnd + aParagraphSpan textRunLength isZero not asBit.

	"and move text position"
	self pushPosition: self spanLength - 1
]

{ #category : #'measurement - testing' }
BlSingleLineTextParagraphMeasurer >> wantsMore [
	^ self line isEmpty or: [ super wantsMore ]
]
