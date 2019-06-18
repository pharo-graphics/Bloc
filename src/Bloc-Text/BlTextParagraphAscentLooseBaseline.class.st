"
I am a baseline which is computed based on ascent property of the paragraph


"
Class {
	#name : #BlTextParagraphAscentLooseBaseline,
	#superclass : #BlTextParagraphBaseline,
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #baseline }
BlTextParagraphAscentLooseBaseline >> computedBaseline: aTextParagraph [
	<return: #Point>

	^ 0 @ aTextParagraph ascent
]
