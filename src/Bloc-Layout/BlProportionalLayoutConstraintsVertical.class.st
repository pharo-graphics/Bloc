Class {
	#name : #BlProportionalLayoutConstraintsVertical,
	#superclass : #BlLayoutConstraintsAxis,
	#instVars : [
		'topFraction',
		'bottomFraction'
	],
	#category : #'Bloc-Layout-Proportional'
}

{ #category : #accessing }
BlProportionalLayoutConstraintsVertical >> bottomFraction [

	^ bottomFraction
]

{ #category : #accessing }
BlProportionalLayoutConstraintsVertical >> bottomFraction: aNumber [

	bottomFraction := aNumber
]

{ #category : #initialization }
BlProportionalLayoutConstraintsVertical >> initialize [

	super initialize.
	
	topFraction := 0.0.
	bottomFraction := 1.0
]

{ #category : #accessing }
BlProportionalLayoutConstraintsVertical >> topFraction [

	^ topFraction
]

{ #category : #accessing }
BlProportionalLayoutConstraintsVertical >> topFraction: aNumber [

	topFraction := aNumber
]
