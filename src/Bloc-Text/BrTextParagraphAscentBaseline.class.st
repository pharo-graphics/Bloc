"
I am a baseline which is computed based on ascent property of the paragraph


"
Class {
	#name : #BrTextParagraphAscentBaseline,
	#superclass : #BrTextParagraphBaseline,
	#category : 'Bloc-Text-Text-Paragraph'
}

{ #category : #baseline }
BrTextParagraphAscentBaseline >> computedBaseline: aTextParagraph [
	<return: #Point>

	^ 0 @ (aTextParagraph ascent + 0.5)
]
