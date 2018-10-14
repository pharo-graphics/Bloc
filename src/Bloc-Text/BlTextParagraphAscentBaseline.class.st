"
I am a baseline which is computed based on ascent property of the paragraph


"
Class {
	#name : #BlTextParagraphAscentBaseline,
	#superclass : #BlTextParagraphBaseline,
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #baseline }
BlTextParagraphAscentBaseline >> computedBaseline: aTextParagraph [
	<return: #Point>

	^ 0 @ aTextParagraph ascent
]
