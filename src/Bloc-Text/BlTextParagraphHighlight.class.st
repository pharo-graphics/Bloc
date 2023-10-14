"
I am a highlight on a composite text selection, which consists of multiple independent non-overlapping monotone text selections.

My main collaborator is a `BlCompositeSelection`.
"
Class {
	#name : 'BlTextParagraphHighlight',
	#superclass : 'Object',
	#instVars : [
		'paint',
		'selection'
	],
	#category : 'Bloc-Text-Text-Paragraph',
	#package : 'Bloc-Text',
	#tag : 'Text-Paragraph'
}

{ #category : 'instance creation' }
BlTextParagraphHighlight class >> paint: aPaint from: aFromIndex to: aToIndex [
	^ self new paint: aPaint from: aFromIndex to: aToIndex
]

{ #category : 'initialization' }
BlTextParagraphHighlight >> initialize [
	super initialize.
	
	paint := BlPaint transparent.
	selection := BlCompositeSelection new
]

{ #category : 'accessing' }
BlTextParagraphHighlight >> paint [

	^ paint
]

{ #category : 'api - highlighting' }
BlTextParagraphHighlight >> paint: aPaint from: aFromIndex to: aToIndex [

	paint := aPaint.
	selection select: aFromIndex to: aToIndex
]

{ #category : 'accessing' }
BlTextParagraphHighlight >> selection [

	^ selection
]
