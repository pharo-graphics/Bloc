"
I am an element with a broken onLayout method that throws Error (SubscriptOutOfBounds)

"
Class {
	#name : #BlExampleElementWithBrokenOnLayout,
	#superclass : #BlElement,
	#category : #'Bloc-Examples-Errors'
}

{ #category : #layout }
BlExampleElementWithBrokenOnLayout >> onLayout: aBounds context: aBlElementBoundsUpdater [
	#() at: 1
]
