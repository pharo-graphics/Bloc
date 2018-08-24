Class {
	#name : #BlSelectedState,
	#superclass : #BlState,
	#category : 'Bloc-State'
}

{ #category : #converting }
BlSelectedState class >> asSymbol [
	^ #selected
]

{ #category : #comparing }
BlSelectedState class >> priority [
	^ 35
]
