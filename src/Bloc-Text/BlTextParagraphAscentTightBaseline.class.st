Class {
	#name : #BlTextParagraphAscentTightBaseline,
	#superclass : #BlTextParagraphBaseline,
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #baseline }
BlTextParagraphAscentTightBaseline >> computedBaseline: aTextParagraph [
	<return: #Point>

	^ aTextParagraph left negated @ aTextParagraph ascent abs
]
