Class {
	#name : 'BlAscentTightBaselineMeasurer',
	#superclass : 'BlTextParagraphBaselineMeasurer',
	#package : 'Bloc',
	#tag : 'Text-Text-Paragraph',
	#package : 'Bloc-Text',
	#tag : 'Text-Paragraph'
}

{ #category : 'baseline' }
BlAscentTightBaselineMeasurer >> computedBaseline: aTextParagraph [

	^ aTextParagraph left negated @ aTextParagraph ascent abs
]
