"
I represent the horizontal constraints of a `BlProportionalLayout`.
"
Class {
	#name : #BlProportionalLayoutConstraintsHorizontal,
	#superclass : #BlLayoutConstraintsAxis,
	#instVars : [
		'left',
		'right'
	],
	#category : #'Bloc-Layout-Proportional'
}

{ #category : #initialization }
BlProportionalLayoutConstraintsHorizontal >> initialize [

	super initialize.
	
	left := 0.0.
	right := 1.0
]

{ #category : #accessing }
BlProportionalLayoutConstraintsHorizontal >> left [

	^ left
]

{ #category : #accessing }
BlProportionalLayoutConstraintsHorizontal >> left: aNumber [

	left := aNumber
]

{ #category : #accessing }
BlProportionalLayoutConstraintsHorizontal >> right [

	^ right
]

{ #category : #accessing }
BlProportionalLayoutConstraintsHorizontal >> right: aNumber [

	right := aNumber
]

{ #category : #'accessing - structure variables' }
BlProportionalLayoutConstraintsHorizontal >> unused [

	^ left + (1.0 - right)
]
