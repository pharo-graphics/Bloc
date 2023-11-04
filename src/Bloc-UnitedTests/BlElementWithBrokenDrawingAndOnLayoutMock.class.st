"
I am an element with broken drawing and onLayout methods
"
Class {
	#name : #BlElementWithBrokenDrawingAndOnLayoutMock,
	#superclass : #BlElement,
	#package : 'Bloc',
	#tag : 'UnitedTests-Errors'
}

{ #category : #drawing }
BlElementWithBrokenDrawingAndOnLayoutMock >> aeDrawOn: aCanvas [

	1 / 0
]

{ #category : #layout }
BlElementWithBrokenDrawingAndOnLayoutMock >> onLayout: aBounds context: aBlElementBoundsUpdater [
	#() at: 1
]
