Class {
	#name : #BrTextParagraphBoundsBaseline,
	#superclass : #BrTextParagraphBaseline,
	#category : 'Bloc-Text-Text-Paragraph'
}

{ #category : #baseline }
BrTextParagraphBoundsBaseline >> computedBaseline: aTextParagraph [
	<return: #Point>

	^ 0 @ ((aTextParagraph ascent - (aTextParagraph bottom / 2.0) + aTextParagraph height) / 2.0)
]
