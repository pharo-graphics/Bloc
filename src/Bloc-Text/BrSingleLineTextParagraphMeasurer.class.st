Class {
	#name : #BrSingleLineTextParagraphMeasurer,
	#superclass : #BrTextParagraphMeasurer,
	#instVars : [
		'line'
	],
	#category : 'Bloc-Text-Text-Paragraph'
}

{ #category : #accessing }
BrSingleLineTextParagraphMeasurer >> accumulatedHeight [
	<return: #Number>

	^ self line height
]

{ #category : #accessing }
BrSingleLineTextParagraphMeasurer >> accumulatedWidth [
	<return: #Number>

	^ self line width
]

{ #category : #initialization }
BrSingleLineTextParagraphMeasurer >> initialize [
	super initialize.
		
	line := BrTextParagraphLine new
]

{ #category : #accessing }
BrSingleLineTextParagraphMeasurer >> line [
	^ line
]

{ #category : #adding }
BrSingleLineTextParagraphMeasurer >> pushSpan: aParagraphSpan [
	self line addSpan: aParagraphSpan.
	
	"after pushing a new span, we should also move glyphs start index"
	textRunStart := textRunEnd + aParagraphSpan textRunLength isZero not asBit.

	"and move text position"
	self pushPosition: self spanLength - 1
]

{ #category : #'measurement - testing' }
BrSingleLineTextParagraphMeasurer >> wantsMore [
	^ self line isEmpty or: [ super wantsMore ]
]
