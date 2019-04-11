"
I am an infinite element with vertical linear layout
"
Class {
	#name : #BlInfiniteExampleElement,
	#superclass : #BlInfiniteElement,
	#category : #'Bloc-Examples-Infinite'
}

{ #category : #initialization }
BlInfiniteExampleElement >> defaultLayout [
	^ BlInfiniteLinearLayout new
]
