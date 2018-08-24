Class {
	#name : #BlIndeterminateState,
	#superclass : #BlState,
	#category : 'Bloc-State'
}

{ #category : #converting }
BlIndeterminateState class >> asSymbol [
	^ #indeterminate
]

{ #category : #comparing }
BlIndeterminateState class >> priority [
	^ 30
]
