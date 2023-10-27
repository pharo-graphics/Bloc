"
I am an element with a broken drawing method that throws Error (ZeroDivide)
"
Class {
	#name : 'BlElementWithBrokenDrawingMock',
	#superclass : 'BlElement',
	#category : 'Bloc-UnitedTests-Errors',
	#package : 'Bloc-UnitedTests',
	#tag : 'Errors'
}

{ #category : 'drawing' }
BlElementWithBrokenDrawingMock >> aeDrawOn: aCanvas [

	1 / 0
]
