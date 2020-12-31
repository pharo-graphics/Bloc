Class {
	#name : #BlSpartaCanvasTextMeasurer,
	#superclass : #BlSpartaTextMeasurer,
	#instVars : [
		'spartaCanvas'
	],
	#category : #'Bloc-Sparta-Text'
}

{ #category : #accessing }
BlSpartaCanvasTextMeasurer >> canvas: anObject [
	spartaCanvas := anObject
]

{ #category : #accessing }
BlSpartaCanvasTextMeasurer >> spartaCanvas [
	^ spartaCanvas
]
