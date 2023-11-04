Class {
	#name : 'BlBoundsBaselineMeasurer',
	#superclass : 'BlTextParagraphBaselineMeasurer',
	#package : 'Bloc',
	#tag : 'Text-Text-Paragraph',
	#package : 'Bloc-Text',
	#tag : 'Text-Paragraph'
}

{ #category : 'baseline' }
BlBoundsBaselineMeasurer >> computedBaseline: aTextParagraph [
	<return: #Point>

	^ aTextParagraph left negated @ aTextParagraph top negated
]
