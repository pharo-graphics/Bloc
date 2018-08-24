Class {
	#name : #BlPressedState,
	#superclass : #BlState,
	#category : 'Bloc-State'
}

{ #category : #converting }
BlPressedState class >> asSymbol [
	^ #pressed
]

{ #category : #comparing }
BlPressedState class >> priority [
	^ 40
]
