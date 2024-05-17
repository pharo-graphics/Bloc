Class {
	#name : #BlTextBorderAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'border',
		'drawAbove'
	],
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #'instance creation' }
BlTextBorderAttribute class >> border: aBlBorder [

	^ self new
		border: aBlBorder;
		yourself
]

{ #category : #accessing }
BlTextBorderAttribute >> border [

	^ border
]

{ #category : #accessing }
BlTextBorderAttribute >> border: aBlBorder [

	border := aBlBorder
]

{ #category : #testing }
BlTextBorderAttribute >> drawAbove: aBoolean [

	drawAbove := aBoolean
]

{ #category : #comparing }
BlTextBorderAttribute >> equals: anAnotherAttribute [

	^ border = anAnotherAttribute border
]

{ #category : #initialization }
BlTextBorderAttribute >> initialize [

	super initialize.
	
	drawAbove := false
]

{ #category : #testing }
BlTextBorderAttribute >> isDrawAbove [

	^ drawAbove
]

{ #category : #printing }
BlTextBorderAttribute >> printOn: aStream [

	aStream
		nextPutAll: 'border: ';
		print: border
]
