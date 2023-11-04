Class {
	#name : #BlAscentTightBaselineMeasurer,
	#superclass : #BlTextParagraphBaselineMeasurer,
	#category : 'Bloc-Text-Text-Paragraph'
}

{ #category : #baseline }
BlAscentTightBaselineMeasurer >> computedBaseline: aTextParagraph [

	^ aTextParagraph left negated @ aTextParagraph ascent abs
]
