"
I represent middle alignment.
See BlLayoutAlignment for more info.

"
Class {
	#name : #BlMiddleAlignment,
	#superclass : #BlRelativeAlignment,
	#category : 'Bloc-Layouts-Alignment'
}

{ #category : #factory }
BlMiddleAlignment class >> horizontal [
	^ BlHorizontalAlignment center
]

{ #category : #factory }
BlMiddleAlignment class >> vertical [
	^ BlVerticalAlignment center
]
