Class {
	#name : #BACanvasTextMeasurer,
	#superclass : #BATextMeasurer,
	#instVars : [
		'aeCanvas'
	],
	#category : #'Bloc-Alexandrie-Text'
}

{ #category : #accessing }
BACanvasTextMeasurer >> canvas [
	"return the Alexandrie canvas"
	^ aeCanvas
]

{ #category : #accessing }
BACanvasTextMeasurer >> canvas: anAeCanvas [

	aeCanvas := anAeCanvas
]
