Class {
	#name : #BlTextParagraphBoundsBaseline,
	#superclass : #BlTextParagraphBaseline,
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #baseline }
BlTextParagraphBoundsBaseline >> computedBaseline: aTextParagraph [
	<return: #Point>

	^ 0 @ ((aTextParagraph ascent - (aTextParagraph bottom / 2.0) + aTextParagraph height) / 2.0)
]
