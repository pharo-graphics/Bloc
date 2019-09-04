"
BlLazyElementValuable is responsible for triggering the rendering and displaying of its element.
"
Class {
	#name : #BlLazyElementValuable,
	#superclass : #BlAsyncElementValuable,
	#category : #'Bloc-Async'
}

{ #category : #private }
BlLazyElementValuable >> updateElement [
	"Update the receiver's element"

	element buildElement
]
