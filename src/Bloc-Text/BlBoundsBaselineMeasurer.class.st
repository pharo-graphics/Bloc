Class {
	#name : 'BlBoundsBaselineMeasurer',
	#superclass : 'BlTextParagraphBaselineMeasurer',
	#category : 'Bloc-Text-Text-Paragraph',
	#package : 'Bloc-Text',
	#tag : 'Text-Paragraph'
}

{ #category : 'baseline' }
BlBoundsBaselineMeasurer >> computedBaseline: aTextParagraph [
	<return: #Point>

	^ aTextParagraph left negated @ aTextParagraph top negated
]
