Class {
	#name : 'BlSingleLineTextParagraphMeasurer',
	#superclass : 'BlTextParagraphMeasurer',
	#instVars : [
		'line'
	],
	#category : 'Bloc-Text-Text-Paragraph'
}

{ #category : 'accessing' }
BlSingleLineTextParagraphMeasurer >> accumulatedHeight [
	<return: #Number>

	^ self line height
]

{ #category : 'accessing' }
BlSingleLineTextParagraphMeasurer >> accumulatedWidth [
	<return: #Number>

	^ self line width
]

{ #category : 'initialization' }
BlSingleLineTextParagraphMeasurer >> initialize [
	super initialize.
		
	line := BlTextParagraphLine new
]

{ #category : 'accessing' }
BlSingleLineTextParagraphMeasurer >> line [
	^ line
]

{ #category : 'adding' }
BlSingleLineTextParagraphMeasurer >> pushSpan: aParagraphSpan [
	self line addSpan: aParagraphSpan.

	"and move text position"
	self pushPosition: aParagraphSpan spanLength - 1
]
