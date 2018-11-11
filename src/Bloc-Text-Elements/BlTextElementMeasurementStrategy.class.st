Class {
	#name : #BlTextElementMeasurementStrategy,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Text-Elements'
}

{ #category : #cleanup }
BlTextElementMeasurementStrategy class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : #accessing }
BlTextElementMeasurementStrategy class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #'as yet unclassified' }
BlTextElementMeasurementStrategy >> boundsOf: aParagraph [
	<return: #BlBounds>

	^ self subclassResponsibility
]
