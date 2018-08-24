Class {
	#name : #BlCheckedState,
	#superclass : #BlState,
	#category : 'Bloc-State'
}

{ #category : #converting }
BlCheckedState class >> asSymbol [
	^ #checked
]

{ #category : #comparing }
BlCheckedState class >> priority [
	^ 35
]
