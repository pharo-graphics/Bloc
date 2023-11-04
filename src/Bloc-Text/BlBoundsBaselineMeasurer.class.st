Class {
	#name : #BlBoundsBaselineMeasurer,
	#superclass : #BlTextParagraphBaselineMeasurer,
	#category : 'Bloc-Text-Text-Paragraph'
}

{ #category : #baseline }
BlBoundsBaselineMeasurer >> computedBaseline: aTextParagraph [
	<return: #Point>

	^ aTextParagraph left negated @ aTextParagraph top negated
]
