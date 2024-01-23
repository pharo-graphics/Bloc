"
I am the most commonly used elevation given in relative to the parent. It allows us to construct independent complex reusable visual components with support of inner elevation (a pyramid of elements).

Note: Relative elevation can be negative!

"
Class {
	#name : #BlRelativeElevation,
	#superclass : #BlElevation,
	#category : 'Bloc-Basic-Properties'
}

{ #category : #accessing }
BlRelativeElevation >> relatedTo: aNumber [
	"Resulting elevation is a sum of a given and my relative one"

	^ aNumber + elevation
]
