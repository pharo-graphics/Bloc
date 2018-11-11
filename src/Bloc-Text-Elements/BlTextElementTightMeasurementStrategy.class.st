Class {
	#name : #BlTextElementTightMeasurementStrategy,
	#superclass : #BlTextElementMeasurementStrategy,
	#category : #'Bloc-Text-Elements'
}

{ #category : #'as yet unclassified' }
BlTextElementTightMeasurementStrategy >> boundsOf: aParagraph [
	<return: #BlBounds>

	^ BlBounds fromRectangle: aParagraph bounds
]
