"
I am an element with a broken drawing method that throws Error (ZeroDivide)

"
Class {
	#name : #BlExampleElementWithBrokenDrawing,
	#superclass : #BlElement,
	#category : #'Bloc-Examples-Errors'
}

{ #category : #drawing }
BlExampleElementWithBrokenDrawing >> drawOnSpartaCanvas: aCanvas [
	1/0
]
