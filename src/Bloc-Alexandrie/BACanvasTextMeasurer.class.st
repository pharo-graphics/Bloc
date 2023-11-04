Class {
	#name : 'BACanvasTextMeasurer',
	#superclass : 'BATextMeasurer',
	#instVars : [
		'aeCanvas'
	],
	#package : 'Bloc',
	#tag : 'Alexandrie-Text',
	#package : 'Bloc-Alexandrie',
	#tag : 'Text'
}

{ #category : 'accessing' }
BACanvasTextMeasurer >> canvas [
	"return the Alexandrie canvas"
	^ aeCanvas
]

{ #category : 'accessing' }
BACanvasTextMeasurer >> canvas: anAeCanvas [

	aeCanvas := anAeCanvas
]
