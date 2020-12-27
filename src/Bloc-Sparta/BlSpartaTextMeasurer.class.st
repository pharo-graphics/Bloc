Class {
	#name : #BlSpartaTextMeasurer,
	#superclass : #BlHostTextMeasurer,
	#instVars : [
		'spaceRenderer'
	],
	#category : #'Bloc-Sparta-Text'
}

{ #category : #dispatch }
BlSpartaTextMeasurer >> measureTextParagraph: aBlTextParagraph [
	self spaceRenderer spartaCanvas measureTextParagraph: aBlTextParagraph
]

{ #category : #accessing }
BlSpartaTextMeasurer >> spaceRenderer [
	^ spaceRenderer
]

{ #category : #accessing }
BlSpartaTextMeasurer >> spaceRenderer: anObject [
	spaceRenderer := anObject
]
