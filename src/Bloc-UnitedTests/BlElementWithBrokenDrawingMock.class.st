"
I am an element with a broken drawing method that throws Error (ZeroDivide)
"
Class {
	#name : #BlElementWithBrokenDrawingMock,
	#superclass : #BlElement,
	#category : #'Bloc-UnitedTests-Errors'
}

{ #category : #drawing }
BlElementWithBrokenDrawingMock >> drawOnSpartaCanvas: aCanvas [
	1/0
]
