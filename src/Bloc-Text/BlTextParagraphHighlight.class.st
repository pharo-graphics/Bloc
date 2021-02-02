Class {
	#name : #BlTextParagraphHighlight,
	#superclass : #Object,
	#instVars : [
		'paint',
		'selection'
	],
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #'api - highlighting' }
BlTextParagraphHighlight >> highlight: aPaint from: aFromIndex to: aToIndex [
	paint := aPaint.
	selection select: aFromIndex to: aToIndex
]

{ #category : #initialization }
BlTextParagraphHighlight >> initialize [
	super initialize.
	
	paint := BlPaint transparent.
	selection := BlCompositeSelection new
]

{ #category : #accessing }
BlTextParagraphHighlight >> paint [
	^ paint
]

{ #category : #accessing }
BlTextParagraphHighlight >> selection [
	^ selection
]
