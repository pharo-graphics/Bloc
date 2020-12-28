Class {
	#name : #BlHostTextMeasurer,
	#superclass : #Object,
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #dispatch }
BlHostTextMeasurer >> measureTextParagraph: aBlTextParagraph [
	self subclassResponsibility
]

{ #category : #dispatch }
BlHostTextMeasurer >> measureTextSpan: aBlTextSpan [
	self subclassResponsibility
]
