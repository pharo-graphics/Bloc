Class {
	#name : #BlTextParagraphBoundsBaseline,
	#superclass : #BlTextParagraphBaseline,
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #baseline }
BlTextParagraphBoundsBaseline >> computedBaseline: aTextParagraph [
	<return: #Point>

	^ aTextParagraph left negated @ aTextParagraph top negated
]
