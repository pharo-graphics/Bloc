Class {
	#name : #BlTextElementMeasurer,
	#superclass : #Object,
	#category : #'Bloc-Text-Elements'
}

{ #category : #dispatch }
BlTextElementMeasurer >> measureTextParagraph: aParagraph [
	aParagraph measureOn: self measurer
]

{ #category : #'instance creation' }
BlTextElementMeasurer >> measurer [
	^ self subclassResponsibility
]
