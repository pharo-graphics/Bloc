"
I calculate text extent using a BlSpartaCanvas that I receive on initialization.
"
Class {
	#name : #BlSpartaCanvasTextMeasurer,
	#superclass : #BlSpartaTextMeasurer,
	#instVars : [
		'spartaCanvas'
	],
	#category : #'Bloc-Sparta-Text'
}

{ #category : #accessing }
BlSpartaCanvasTextMeasurer >> canvas: aSpartaCanvas [

	spartaCanvas := aSpartaCanvas
]

{ #category : #accessing }
BlSpartaCanvasTextMeasurer >> spartaCanvas [
	^ spartaCanvas
]
