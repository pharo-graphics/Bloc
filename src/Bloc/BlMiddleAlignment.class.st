"
I represent middle alignment.
See BlLayoutAlignment for more info.

"
Class {
	#name : 'BlMiddleAlignment',
	#superclass : 'BlRelativeAlignment',
	#package : 'Bloc',
	#tag : 'Layouts-Alignment'
}

{ #category : 'factory' }
BlMiddleAlignment class >> horizontal [
	^ BlHorizontalAlignment center
]

{ #category : 'factory' }
BlMiddleAlignment class >> vertical [
	^ BlVerticalAlignment center
]
