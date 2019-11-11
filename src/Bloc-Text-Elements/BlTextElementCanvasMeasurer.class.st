Class {
	#name : #BlTextElementCanvasMeasurer,
	#superclass : #BlTextElementMeasurer,
	#instVars : [
		'canvas'
	],
	#category : #'Bloc-Text-Elements'
}

{ #category : #accessing }
BlTextElementCanvasMeasurer >> canvas [
	^ canvas
]

{ #category : #accessing }
BlTextElementCanvasMeasurer >> canvas: anObject [
	canvas := anObject
]

{ #category : #'instance creation' }
BlTextElementCanvasMeasurer >> measurer [
	<return: #SpartaCanvas>

	^ canvas
]
