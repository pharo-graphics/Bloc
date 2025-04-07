"
I represent the vertical constraints of a `BlProportionalLayout`.
"
Class {
	#name : #BlProportionalLayoutConstraintsVertical,
	#superclass : #BlLayoutConstraintsAxis,
	#instVars : [
		'top',
		'bottom'
	],
	#category : #'Bloc-Layout-Proportional'
}

{ #category : #accessing }
BlProportionalLayoutConstraintsVertical >> bottom [

	^ bottom
]

{ #category : #accessing }
BlProportionalLayoutConstraintsVertical >> bottom: aNumber [

	bottom := aNumber
]

{ #category : #initialization }
BlProportionalLayoutConstraintsVertical >> initialize [

	super initialize.
	
	top := 0.0.
	bottom := 1.0
]

{ #category : #accessing }
BlProportionalLayoutConstraintsVertical >> top [

	^ top
]

{ #category : #accessing }
BlProportionalLayoutConstraintsVertical >> top: aNumber [

	top := aNumber
]

{ #category : #'accessing - structure variables' }
BlProportionalLayoutConstraintsVertical >> unused [

	^ top + 1.0 - bottom
]
