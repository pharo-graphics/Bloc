"
I represent the horizontal constraints of a `BlProportionalLayout`.
"
Class {
	#name : #BlProportionalLayoutConstraintsHorizontal,
	#superclass : #BlLayoutConstraintsAxis,
	#instVars : [
		'leftFraction',
		'rightFraction'
	],
	#category : #'Bloc-Layout-Proportional'
}

{ #category : #initialization }
BlProportionalLayoutConstraintsHorizontal >> initialize [

	super initialize.
	
	leftFraction := 0.0.
	rightFraction := 1.0
]

{ #category : #accessing }
BlProportionalLayoutConstraintsHorizontal >> leftFraction [

	^ leftFraction
]

{ #category : #accessing }
BlProportionalLayoutConstraintsHorizontal >> leftFraction: aNumber [

	leftFraction := aNumber
]

{ #category : #accessing }
BlProportionalLayoutConstraintsHorizontal >> rightFraction [

	^ rightFraction
]

{ #category : #accessing }
BlProportionalLayoutConstraintsHorizontal >> rightFraction: aNumber [

	rightFraction := aNumber
]
