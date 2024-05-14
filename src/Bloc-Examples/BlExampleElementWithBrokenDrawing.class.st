"
I am an element with a broken drawing method that throws Error (ZeroDivide)

"
Class {
	#name : #BlExampleElementWithBrokenDrawing,
	#superclass : #BlElement,
	#category : #'Bloc-Examples-Errors'
}

{ #category : #drawing }
BlExampleElementWithBrokenDrawing >> aeDrawOn: aeCanvas [

	1/0
]
