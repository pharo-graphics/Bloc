Class {
	#name : #BlFocusedState,
	#superclass : #BlState,
	#category : 'Bloc-State'
}

{ #category : #converting }
BlFocusedState class >> asSymbol [
	^ #focused
]

{ #category : #comparing }
BlFocusedState class >> priority [
	^ 20
]
