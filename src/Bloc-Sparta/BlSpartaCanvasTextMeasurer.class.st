Class {
	#name : #BlSpartaCanvasTextMeasurer,
	#superclass : #BlSpartaTextMeasurer,
	#instVars : [
		'spartaCanvas'
	],
	#category : #'Bloc-Sparta-Text'
}

{ #category : #accessing }
BlSpartaCanvasTextMeasurer >> spartaCanvas [
	^ spartaCanvas
]

{ #category : #accessing }
BlSpartaCanvasTextMeasurer >> spartaCanvas: anObject [
	spartaCanvas := anObject
]
