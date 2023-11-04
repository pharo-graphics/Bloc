"
I am an element with a broken drawing method that throws Error (ZeroDivide)
"
Class {
	#name : #BlElementWithBrokenDrawingMock,
	#superclass : #BlElement,
	#package : 'Bloc',
	#tag : 'UnitedTests-Errors'
}

{ #category : #drawing }
BlElementWithBrokenDrawingMock >> aeDrawOn: aCanvas [

	1 / 0
]
