"
I am a baseline which is computed based on ascent property of the paragraph


"
Class {
	#name : 'BlAscentLooseBaselineMeasurer',
	#superclass : 'BlTextParagraphBaselineMeasurer',
	#category : 'Bloc-Text-Text-Paragraph',
	#package : 'Bloc-Text',
	#tag : 'Text-Paragraph'
}

{ #category : 'baseline' }
BlAscentLooseBaselineMeasurer >> computedBaseline: aTextParagraph [
	<return: #Point>

	^ 0 @ aTextParagraph ascent abs 
]
