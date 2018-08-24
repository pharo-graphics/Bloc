Class {
	#name : #BlArrowheadNone,
	#superclass : #BlArrowheadElement,
	#category : 'Bloc-Geometry-Arrowheads'
}

{ #category : #changes }
BlArrowheadNone >> onWidthChanged: aNumber [
	self size: 0 asPoint.
	self border: (self border copyWithWidth: 0)
]
