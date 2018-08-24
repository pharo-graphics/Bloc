Class {
	#name : #BlDisabledState,
	#superclass : #BlState,
	#category : 'Bloc-State'
}

{ #category : #converting }
BlDisabledState class >> asSymbol [
	^ #disabled
]

{ #category : #comparing }
BlDisabledState class >> priority [
	^ 50
]
