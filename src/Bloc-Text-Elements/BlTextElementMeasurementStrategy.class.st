Class {
	#name : 'BlTextElementMeasurementStrategy',
	#superclass : 'Object',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Bloc-Text-Elements',
	#package : 'Bloc-Text-Elements'
}

{ #category : 'cleanup' }
BlTextElementMeasurementStrategy class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : 'accessing' }
BlTextElementMeasurementStrategy class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'measuring' }
BlTextElementMeasurementStrategy >> boundsOf: aParagraph [
	"Answer an instance of BlBounds corresponding to aParagraph."

	^ self subclassResponsibility
]
