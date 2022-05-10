Class {
	#name : #BlAscentTightBaselineMeasurer,
	#superclass : #BlTextParagraphBaselineMeasurer,
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #baseline }
BlAscentTightBaselineMeasurer >> computedBaseline: aTextParagraph [
	<return: #Point>

	^ aTextParagraph left negated @ aTextParagraph ascent abs
]
