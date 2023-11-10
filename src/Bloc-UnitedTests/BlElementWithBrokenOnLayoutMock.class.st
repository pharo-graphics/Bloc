"
I am an element with a broken onLayout method that throws Error (SubscriptOutOfBounds)
"
Class {
	#name : #BlElementWithBrokenOnLayoutMock,
	#superclass : #BlElement,
	#category : 'Bloc-UnitedTests-Errors'
}

{ #category : #layout }
BlElementWithBrokenOnLayoutMock >> onLayout: aBounds context: aBlElementBoundsUpdater [
	#() at: 1
]
