"
I am a label that when the space is less than my width, I cut the text and add ... as ending

"
Class {
	#name : #BlShrinkingTextElement,
	#superclass : #BlTextElement,
	#instVars : [
		'originalText'
	],
	#category : #'Bloc-Text-Elements'
}

{ #category : #layout }
BlShrinkingTextElement >> onMeasure: anExtentMeasurementSpec [
	super onMeasure: anExtentMeasurementSpec.
	(self measuredWidth isZero not and: [self paragraph width > self measuredWidth]) ifTrue: [				 
		| dotsParagraph cutSubText toPosition |
		dotsParagraph := self createTextParagraph.
		dotsParagraph text: '...' asRopedText.
		self basicMeasureParagraph: dotsParagraph.
		toPosition := self indexAtScreenPosition: (self measuredWidth - (dotsParagraph width)) - 1 @ 1.
		toPosition >=1 ifTrue: [
			cutSubText := self originalText copy from: 1 to: toPosition.
			text := cutSubText insertString: '...' at: cutSubText size.
			paragraph := nil.
			super onMeasure: anExtentMeasurementSpec ] ]
]

{ #category : #accessing }
BlShrinkingTextElement >> originalText [
	^ originalText ifNil: [ originalText := self text copy ]
]
