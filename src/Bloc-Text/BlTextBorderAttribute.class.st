Class {
	#name : #BlTextBorderAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'border',
		'isAbove'
	],
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #'instance creation' }
BlTextBorderAttribute class >> border: aBlBorder above: aBoolean [

	^ self new
		border: aBlBorder;
		above: aBoolean;
		yourself
]

{ #category : #testing }
BlTextBorderAttribute >> above: aBoolean [

	isAbove := aBoolean
]

{ #category : #accessing }
BlTextBorderAttribute >> border [

	^ border
]

{ #category : #accessing }
BlTextBorderAttribute >> border: aBlBorder [

	border := aBlBorder
]

{ #category : #comparing }
BlTextBorderAttribute >> equals: anotherAttribute [

	^ border = anotherAttribute border and: [ isAbove = anotherAttribute isAbove ]
]

{ #category : #initialization }
BlTextBorderAttribute >> initialize [

	super initialize.
	
	isAbove := false
]

{ #category : #testing }
BlTextBorderAttribute >> isAbove [

	^ isAbove
]

{ #category : #printing }
BlTextBorderAttribute >> printOn: aStream [

	aStream nextPutAll: (isAbove
		ifTrue: [ 'border-above: ' ]
		ifFalse: [ 'border-below: ' ]).

	aStream print: border
]
