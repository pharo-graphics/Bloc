Class {
	#name : #BlArrowheadRectangle,
	#superclass : #BlArrowheadElement,
	#category : 'Bloc-Geometry-Arrowheads'
}

{ #category : #changes }
BlArrowheadRectangle >> onWidthChanged: aNumber [

	self size: aNumber * 3 asPoint.
	self border: (self border copyWithWidth: aNumber)
]
