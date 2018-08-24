Class {
	#name : #BlHoveredState,
	#superclass : #BlState,
	#category : 'Bloc-State'
}

{ #category : #converting }
BlHoveredState class >> asSymbol [
	^ #hovered
]

{ #category : #comparing }
BlHoveredState class >> priority [
	^ 30
]
